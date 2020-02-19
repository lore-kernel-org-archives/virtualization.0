From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH] iommu/virtio: Build virtio-iommu as module
Date: Wed, 19 Feb 2020 12:41:33 +0100
Message-ID: <20200219114133.GA156984@myrica>
References: <20200214163827.1606668-1-jean-philippe@linaro.org>
 <20200219111604.GH1961@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200219111604.GH1961@8bytes.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

On Wed, Feb 19, 2020 at 12:16:04PM +0100, Joerg Roedel wrote:
> On Fri, Feb 14, 2020 at 05:38:27PM +0100, Jean-Philippe Brucker wrote:
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > Now that the infrastructure changes are in place, enable virtio-iommu to
> > be built as a module. Remove the redundant pci_request_acs() call, since
> > it's not exported but is already invoked during DMA setup.
> 
> Which infrastructure changes do you mean? Does this depend on the x86
> enablement patch-set in any way?

No, I meant Will's changes in 5.6 to make the SMMU drivers modular. This
patch doesn't depend on the x86 enablement patch-set, but there is a small
conflict in Kconfig since they both modify it (locally I have this patch
applied on top of the x86 enablement).

Thanks,
Jean
