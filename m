From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 16/17] add kmap_atomic_pte for mapping highpte pages
Date: Mon, 2 Apr 2007 09:18:19 +0200
Message-ID: <200704020918.20008.ak@suse.de>
References: <20070402055652.610711908@goop.org>
	<20070402055705.499213579@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070402055705.499213579@goop.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org


> +}
> +
> +/* Flush all unused kmap mappings in order to remove stray
> +   mappings. */
> +void kmap_flush_unused(void)
> +{
> +	spin_lock(&kmap_lock);
> +	flush_all_zero_pkmaps();
> +	spin_unlock(&kmap_lock);
>  }

Who calls this now?

-Andi
