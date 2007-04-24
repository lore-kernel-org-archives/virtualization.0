From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 22/25] xen: xen-netfront: use skb.cb for storing private
 data
Date: Mon, 23 Apr 2007 21:34:55 -0700
Message-ID: <462D88EF.9030007@goop.org>
References: <20070423215638.563901986@goop.org> <20070423215713.550883195@goop.org> <20070424014528.GA27789@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751613AbXDXEe3@vger.kernel.org>
In-Reply-To: <20070424014528.GA27789@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Herbert Xu wrote:
> Thanks Jeremy.  The patch looks good.

Could you give netfront an overall review as well?  I know you're
already pretty familiar with it, but if you could cast a fresh eye over
it, that would be helpful.

Thanks,
    J
