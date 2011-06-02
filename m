From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [TRIVIAL PATCH V2 next 12/15] video: Convert vmalloc/memset to
	vzalloc
Date: Thu, 2 Jun 2011 17:26:28 +0900
Message-ID: <20110602082628.GI6087__25349.2605327212$1307027606$gmane$org@linux-sh.org>
References: <cover.1306603968.git.joe@perches.com>
	<77538de911b8af99f68b7bcfbaaedce8e40db04f.1306603968.git.joe@perches.com>
	<201105281948.12941.heiko@sntech.de>
	<1306606413.20336.9.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306606413.20336.9.camel@Joe-Laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: linux-fbdev@vger.kernel.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Jiri Kosina <trivial@kernel.org>, Heiko St?bner <heiko@sntech.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com, Jaya Kumar <jayalk@intworks.biz>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 28, 2011 at 11:13:33AM -0700, Joe Perches wrote:
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> Heiko St??bner <heiko@sntech.de> pointed out I can't type...
> s/vmalloc/vmalloc/ doesn't do much.
> 
>  drivers/video/arcfb.c        |    5 ++---
>  drivers/video/broadsheetfb.c |    4 +---
>  drivers/video/hecubafb.c     |    5 ++---
>  drivers/video/metronomefb.c  |    4 +---
>  drivers/video/xen-fbfront.c  |    3 +--
>  5 files changed, 7 insertions(+), 14 deletions(-)
> 
v2 applied.
