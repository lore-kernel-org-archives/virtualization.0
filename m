From: Joerg Roedel <jroedel@suse.de>
Subject: Re: AMD IOMMU + SME + amdgpu regression
Date: Mon, 22 Jun 2020 12:02:57 +0200
Message-ID: <20200622100257.GD31822@suse.de>
References: <1591915710.rakbpzst8h.none.ref@localhost>
 <1591915710.rakbpzst8h.none@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1591915710.rakbpzst8h.none@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Daniel Drake <drake@endlessm.com>, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, linux-samsung-soc@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, linux-rockchip@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, Andy Gross <agross@kernel.org>, David Rientjes <rientjes@google.com>, linux-s390@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, virtualization@lists.linux-foundation.org, jonathan.derrick@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Alex,

On Thu, Jun 11, 2020 at 07:05:21PM -0400, Alex Xu (Hello71) wrote:
> I am using an ASRock B450 Pro4 with Ryzen 1600 and ASUS RX 480. I don't 
> understand this code at all, but let me know what I can do to 
> troubleshoot.

Does it boot without SME enabled?


Regards,

	Joerg
