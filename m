From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 4/5] iommu: intel: Use generic_iommu_put_resv_regions()
Date: Thu, 19 Dec 2019 16:35:41 +0100
Message-ID: <20191219153541.GA21694__36920.8386678778$1576769778$gmane$org@8bytes.org>
References: <20191218134205.1271740-1-thierry.reding@gmail.com>
 <20191218134205.1271740-5-thierry.reding@gmail.com>
 <2b3020a1-221c-f86b-6440-e9ef65f0c12e@linux.intel.com>
 <20191219124747.GA1440537@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191219124747.GA1440537@ulmo>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 19, 2019 at 01:47:47PM +0100, Thierry Reding wrote:
> On Thu, Dec 19, 2019 at 09:53:22AM +0800, Lu Baolu wrote:
> > Please tweak the title to
> > 
> > "iommu/vt-d: Use generic_iommu_put_resv_regions()"
> > 
> > then,
> > 
> > Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > Best regards,
> > baolu
> 
> Joerg, do you want me to resend with this change or is it more efficient
> if you fix up the subject while applying?

No need to re-send, I'll fix it up in this patch and in the others too.


	Joerg
