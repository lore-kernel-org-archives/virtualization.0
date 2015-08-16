From: Victor Kaplansky <victork@redhat.com>
Subject: [PATCH v2 0/2] virtio-net: default_mtu - new conf. field
Date: Sun, 16 Aug 2015 16:42:15 +0300
Message-ID: <1439732494-29765-1-git-send-email-victork__24816.4748111323$1440078038$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This set of two patches adds a new field called default_mtu to
the configuration area of network devices. The motivation is to
allow libvirt to set initial MTU different from 1500 on guests
virtual NICs.  We also propose to use this new field to report
MTU changes by the guest OS to the device to facilitate
debugging and mtu tunning.

The first patch just clarify the definition of existing fields in
network device configuration are. The second one adds default_mtu
and its description.

v2 changes:
  * address comments by Michael S. Tsirkin:
    - mac is driver-read-only.
    - two status bits depend on different feature flags.
    - use should/must only in conformance statements.
    - rephrase "is set" -> "is offered" for features.
    - other cosmetic changes.
    - added conformance statements for a device and for a driver
      regarding new 'default_mtu" field.

Victor Kaplansky (2):
  virtio-net: rephrase devconf fields description
  virtio-net: add default_mtu configuration field

 content.tex | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 11 deletions(-)

-- 
--Victor
