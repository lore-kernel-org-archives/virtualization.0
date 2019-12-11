From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 5/5] iommu: virtio: Use iommu_put_resv_regions_simple()
Date: Wed, 11 Dec 2019 16:44:16 +0100
Message-ID: <20191211154416.GA1927@myrica>
References: <20191209145007.2433144-1-thierry.reding@gmail.com>
 <20191209145007.2433144-6-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191209145007.2433144-6-thierry.reding@gmail.com>
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
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 09, 2019 at 03:50:07PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Use the new standard function instead of open-coding it.
> 
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: virtualization@lists.linux-foundation.org
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
