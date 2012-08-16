From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 04/18] Drivers: hv: kvp: Support the new IP injection
 messages
Date: Thu, 16 Aug 2012 13:50:29 -0700
Message-ID: <20120816205029.GA9176@kroah.com>
References: <1344877584-21738-1-git-send-email-kys@microsoft.com>
 <1344877627-21779-1-git-send-email-kys@microsoft.com>
 <1344877627-21779-4-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1344877627-21779-4-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 13, 2012 at 10:06:53AM -0700, K. Y. Srinivasan wrote:
> +	default:
> +		utf16s_to_utf8s((wchar_t *)in->kvp_ip_val.adapter_id,
> +				MAX_ADAPTER_ID_SIZE,
> +				UTF16_LITTLE_ENDIAN,
> +				(__u8 *)out->body.kvp_ip_val.adapter_id,
> +				MAX_ADAPTER_ID_SIZE);
> +
> +		out->body.kvp_ip_val.addr_family =
> +		in->kvp_ip_val.addr_family;

That's some wierd indenting, did you really mean to do that?

greg k-h
