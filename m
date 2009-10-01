From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] virtio_console: Add support for multiple ports for
	generic guest and host communication
Date: Thu, 1 Oct 2009 11:00:48 +0200
Message-ID: <200910011100.48087.borntraeger__42200.3724765547$1254387885$gmane$org@de.ibm.com>
References: <1252678386-17404-1-git-send-email-amit.shah@redhat.com>
	<200909291531.23389.borntraeger@de.ibm.com>
	<20090930171321.GA17200@amit-x200.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090930171321.GA17200@amit-x200.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Mittwoch 30 September 2009 19:13:21 schrieb Amit Shah:
> - uses port->id instead of a static hvc_vtermno to pass on a value to
>   hvc_alloc(). Motivation explained within comments in the code.

[...]
> +	 * The first argument of hvc_alloc() is the virtual console
> +	 * number. hvc_alloc() checks if a console with the same value
> +	 * was used in hvc_instantiate(). We may not end up passing
> +	 * the same value here (we use the value 0 in
> +	 * hvc_instantiate() but the console port may not be at id
> +	 * 0). This isn't a problem, though. Nothing in hvc really
> +	 * depends on these numbers and since this number is passed on
> +	 * to us when cons_get/put_chars() is called, it's preferable
> +	 * to pass on the port->id so that we can get the port struct
> +	 * via get_port_from_id().
[...]
> +	port->hvc = hvc_alloc(port->id, 0, &virtio_cons, PAGE_SIZE);

I am not sure if this is going to be ok. 

When I change the old code (without your patch) to use vtermno=0 in 
hvc_instantiate and vtermno=1 in hvc_alloc I get 
"Warning: unable to open an initial console."

It seems to me that we have to pass the same values.

Christian
