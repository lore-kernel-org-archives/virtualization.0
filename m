From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 5/5] iommu: virt: Use iommu_put_resv_regions_simple()
Date: Mon, 2 Sep 2019 23:54:42 -0700
Message-ID: <20190903065442.GB28322__32440.8688627713$1567493700$gmane$org@infradead.org>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
	<20190829111752.17513-6-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190829111752.17513-6-thierry.reding@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

I think the subject should say virtio instead of virt.
