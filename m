From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 23/25] xen: Lockdep fixes for xen-netfront
Date: Mon, 23 Apr 2007 21:36:10 -0700
Message-ID: <462D893A.1020201@goop.org>
References: <E1HgBbr-0007Ob-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <E1HgBbr-0007Ob-00@gondolin.me.apana.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Herbert Xu wrote:
> You don't need to disable BH in netif_poll since it's always called
> with BH disabled.
>   

Ah, yes, you mentioned that before.  I'll fix it up.

    J
