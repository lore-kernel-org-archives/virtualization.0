From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [virtio-dev] [RFC PATCH v2 1/5] iommu: Add virtio-iommu driver
Date: Wed, 29 Nov 2017 15:17:40 +0000
Message-ID: <73427923-e62a-e277-42a2-cd37141fa122__41129.7977356755$1511968488$gmane$org@arm.com>
References: <20171117185211.32593-1-jean-philippe.brucker@arm.com>
	<20171117185211.32593-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171117185211.32593-2-jean-philippe.brucker@arm.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "devel@acpica.org" <devel@acpica.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robert.moore@intel.com" <robert.moore@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "lv.zheng@intel.com" <lv.zheng@intel.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
List-Id: virtualization@lists.linuxfoundation.org

On 17/11/17 18:52, Jean-Philippe Brucker wrote:
[...]
> +struct viommu_domain {
> +	struct iommu_domain		domain;
> +	struct viommu_dev		*viommu;
> +	struct mutex			mutex;
> +	unsigned int			id;
> +
> +	spinlock_t			mappings_lock;
> +	struct rb_root_cached		mappings;
> +
> +	/* Number of endpoints attached to this domain */
> +	refcount_t			endpoints;

Refcount_t is the wrong tool for this, I went back to an unsigned int (and
rebased onto v4.15-rc1), on branch virtio-iommu/base.

Thanks,
Jean
