From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] VirtioConsole support.
Date: Fri, 28 Oct 2011 11:19:40 -0700
Message-ID: <4EAAF23C.8050102__27308.3472312011$1321323089$gmane$org@codeaurora.org>
References: <20111027173527.GA23839@phenom.dumpdata.com>
	<1319751802-27013-1-git-send-email-miche@google.com>
	<1319770558.2529.20.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1319770558.2529.20.camel@Joe-Laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Joe Perches <joe@perches.com>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kroah-Hartman <gregkh@suse.de>, Miche Baker-Harvey <miche@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On 10/27/11 19:55, Joe Perches wrote:
>
> @@ -845,6 +857,19 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
>  	kref_init(&hp->kref);
>  
>  	INIT_WORK(&hp->tty_resize, hvc_set_winsz);
> +	/*
> +	 * make each console its own struct console.
> +	 * No need to do allocation and copy under lock.
> +	 */
> +	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
> +	if (!cp) {
> +		kfree(hp);
> +		mutex_unlock(&hvc_ports_mutex);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	memcpy(cp, &hvc_console, sizeof(*cp));
> The kzalloc should be kmalloc as the allocated
> memory is immediately overwritten.

Even better would be kmemdup().

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
