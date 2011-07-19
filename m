From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 5/8] Staging: hv: mousevsc: Fix checkpatch errors and
 warnings
Date: Tue, 19 Jul 2011 12:28:33 -0700
Message-ID: <1311103713.12882.13.camel@Joe-Laptop>
References: <1311101018-23370-1-git-send-email-kys@microsoft.com>
	 <1311101065-23417-1-git-send-email-kys@microsoft.com>
	 <1311101065-23417-5-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1311101065-23417-5-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-07-19 at 11:44 -0700, K. Y. Srinivasan wrote:
> Fix checkpatch errors and warnings.
[]
> diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
[]
> @@ -53,7 +53,7 @@ struct hv_input_dev_info {
> -#pragma pack(push,1)
> +#pragma pack(push, 1)
>  /*
>   * Message types in the synthetic input protocol
>   */

Perhaps it's better and more consistent with
other kernel style uses to remove #pragma pack[...]
and mark the individual structs with __packed;

$ grep -rP --include=*.[ch] "pragma.*pack" * | wc -l
221
$ grep -rP --include=*.[ch] "(__attribute__.*packed|\b__packed\b)" * | wc -l
5553
