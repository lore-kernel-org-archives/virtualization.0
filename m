From: Luca Coelho <luca@coelho.fi>
Subject: Re: [PATCH 5/8] linux: drop __bitwise__ everywhere
Date: Mon, 19 Dec 2016 11:09:28 +0200
Message-ID: <1482138568.26174.8.camel__44886.9113497951$1483728378$gmane$org@coelho.fi>
References: <1481778865-27667-1-git-send-email-mst@redhat.com>
	<1481778865-27667-6-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481778865-27667-6-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>, Mike Snitzer <snitzer@redhat.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, dm-devel@redhat.com, target-devel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>, linux-samsung-soc@vger.kernel.org, "James E.J.
	Bottomley" <jejb@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org, Stefan Schmidt <stefan@osg.samsung.com>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>, open-iscsi@googlegroups.com, Shaohua Li <shli@kernel.org>, Johannes Berg <johannes.berg@intel.com>, Intel Linux Wireless <linuxwifi@intel.com>, Alexander Aring <aar@pengutronix.de>, linux-raid@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>, Chris Leech <cleech@re>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2016-12-15 at 07:15 +0200, Michael S. Tsirkin wrote:
> __bitwise__ used to mean "yes, please enable sparse checks
> unconditionally", but now that we dropped __CHECK_ENDIAN__
> __bitwise is exactly the same.
> There aren't many users, replace it by __bitwise everywhere.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h    | 2 +-
>  drivers/md/dm-cache-block-types.h                | 6 +++---
>  drivers/net/ethernet/sun/sunhme.h                | 2 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-fw-file.h | 4 ++--

For drivers/net/wireless/intel/iwlwifi/iwl-fw-file.h:

Acked-by: Luca Coelho <luciano.coelho@intel.com>

--
Luca.
