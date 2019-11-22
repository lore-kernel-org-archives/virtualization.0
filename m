From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC virtio 12/13] virtio-iommu: Add built-in topology description
Date: Fri, 22 Nov 2019 11:49:59 +0100
Message-ID: <20191122105000.800410-13-jean-philippe@linaro.org>
References: <20191122105000.800410-1-jean-philippe@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191122105000.800410-1-jean-philippe@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, virtio-dev@lists.oasis-open.org
Cc: lorenzo.pieralisi@arm.com, mst@redhat.com, gregkh@linuxfoundation.org, joro@8bytes.org, sudeep.holla@arm.com, rjw@rjwysocki.net, eric.auger@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, guohanjun@huawei.com, bhelgaas@google.com, lenb@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add a lightweight method to describe the IOMMU topology in the config
space, guarded by a new feature bit. A list of capabilities in the
config space describes the devices managed by the IOMMU and their
endpoint IDs.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 virtio-iommu.tex | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/virtio-iommu.tex b/virtio-iommu.tex
index 28c562b..2b29873 100644
--- a/virtio-iommu.tex
+++ b/virtio-iommu.tex
@@ -67,6 +67,9 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
 
 \item[VIRTIO_IOMMU_F_MMIO (5)]
   The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
+
+\item[VIRTIO_IOMMU_F_TOPOLOGY (6)]
+  Topology description is available at \field{topo_offset}.
 \end{description}
 
 \drivernormative{\subsubsection}{Feature bits}{Device Types / IOMMU Device / Feature bits}
@@ -97,6 +100,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / IOMMU Device /
     le32 end;
   } domain_range;
   le32 probe_size;
+  le16 topo_offset;
 };
 \end{lstlisting}
 
@@ -141,6 +145,90 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
 If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
 device SHOULD NOT let endpoints access the guest-physical address space.
 
+\subsubsection{Built-in topology description}\label{sec:Device Types / IOMMU Device / Device initialization / topology}
+
+The device manages memory accesses from endpoints, identified by endpoint
+IDs. The driver can discover which endpoint ID corresponds to an endpoint
+using several methods, depending on the platform. Platforms described
+with device tree use the \texttt{iommus} and \texttt{iommu-map} properties
+embedded into device nodes for this purpose. Platforms described with
+ACPI use a table such as the Virtual I/O Table. Platforms that do not
+support either device tree or ACPI may embed a minimalistic description
+in the device configuration space.
+
+An important disadvantage of describing the topology from within the
+device is the lack of initialization ordering information. Out-of-band
+descriptions such as device tree and ACPI let the operating system know
+about device dependencies so that it can initialize supplier devices
+(IOMMUs) before their consumers (endpoints). Platforms using the
+VIRTIO_IOMMU_F_TOPOLOGY feature have to communicate the device dependency
+in another way.
+
+If the VIRTIO_IOMMU_F_TOPOLOGY feature is negotiated, \field{topo_offset}
+is the offset between the beginning of the device-specific configuration
+space (virtio_iommu_config) and the first topology structure header. A
+topology structures defines the endpoint ID of one or more endpoints
+managed by the virtio-iommu device.
+
+\begin{lstlisting}
+struct virtio_iommu_topo_head {
+  le16 type;
+  le16 next;
+};
+\end{lstlisting}
+
+\field{next} is the offset between the beginning of the device-specific
+configuration space and the next topology structure header. When
+\field{next} is zero, this is the last structure.
+
+\field{type} describes the type of structure:
+\begin{description}
+  \item[VIRTIO_IOMMU_TOPO_PCI_RANGE (0)] struct virtio_iommu_topo_pci_range
+  \item[VIRTIO_IOMMU_TOPO_ENDPOINT (1)] struct virtio_iommu_topo_endpoint
+\end{description}
+
+\paragraph{PCI range}\label{sec:Device Types / IOMMU Device / Device initialization / topology / PCI range}
+
+\begin{lstlisting}
+struct virtio_iommu_topo_pci_range {
+  struct virtio_iommu_topo_head head;
+  le32 endpoint_start;
+  le16 hierarchy;
+  le16 requester_start;
+  le16 requester_end;
+  le16 reserved;
+};
+\end{lstlisting}
+
+The PCI range structure describes the endpoint IDs of a series of PCI
+devices.
+
+\begin{description}
+  \item[\field{hierarchy}] Identifier of the PCI hierarchy. Sometimes
+    called PCI segment or domain number.
+  \item[\field{requester_start}] First requester ID in the range.
+  \item[\field{requester_end}] Last requester ID in the range.
+  \item[\field{endpoint_start}] First endpoint ID.
+\end{description}
+
+The correspondence between a PCI requester ID in the range
+[ requester_start; requester_end ] and its endpoint IDs is a linear
+transformation: endpoint_id = requester_id - requester_start +
+endpoint_start.
+
+\paragraph{Single endpoint}\label{sec:Device Types / IOMMU Device / Device initialization / topology / Single endpoint}
+
+\begin{lstlisting}
+struct virtio_iommu_topo_endpoint {
+  struct virtio_iommu_topo_head head;
+  le32 endpoint;
+  le64 address;
+};
+\end{lstlisting}
+
+\field{endpoint} is the ID of a single endpoint, identified by its first
+MMIO address in the physical address space.
+
 \subsection{Device operations}\label{sec:Device Types / IOMMU Device / Device operations}
 
 Driver send requests on the request virtqueue, notifies the device and
-- 
2.24.0
