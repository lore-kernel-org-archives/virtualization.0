From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/virtio: Remove unused variable
Date: Wed, 30 Oct 2019 10:43:15 +0100
Message-ID: <20191030094315.GC7254__33541.0895686195$1572428612$gmane$org@8bytes.org>
References: <20191025161340.GA31368@cristiane-Inspiron-5420>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191025161340.GA31368@cristiane-Inspiron-5420>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cristiane Naves <cristianenavescardoso09@gmail.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, outreachy-kernel@googlegroups.com, iommu@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 25, 2019 at 01:13:40PM -0300, Cristiane Naves wrote:
> Remove the variable of return. Issue found by
> coccicheck(scripts/coccinelle/misc/returnvar.cocci)
> 
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/iommu/virtio-iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied for v5.5, thanks.
