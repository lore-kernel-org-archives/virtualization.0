From: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: PATCH 7/8] lguest: the block driver
Date: Wed, 11 Apr 2007 08:29:08 +0300
Message-ID: <84144f020704102229i648bcd39xd579fa63a6e1c62f__23197.1048437574$1176286717$gmane$org@mail.gmail.com>
References: <1176203068.26372.21.camel@localhost.localdomain>
	<1176203176.26372.25.camel@localhost.localdomain>
	<1176203231.26372.27.camel@localhost.localdomain>
	<1176203285.26372.29.camel@localhost.localdomain>
	<1176203333.26372.31.camel@localhost.localdomain>
	<1176203475.26372.37.camel@localhost.localdomain>
	<1176203528.26372.40.camel@localhost.localdomain>
	<84144f020704100428r6e35e34cued8758c94728a6a0@mail.gmail.com>
	<84144f020704100436y3405f104x8345c72556d961e9@mail.gmail.com>
	<1176264024.26372.93.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1176264024.26372.93.camel@localhost.localdomain>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, jens.axboe@oracle.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 4/11/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> What a question!  end_request() doesn't end a request!  What a crazy
> idea!

Aah, indeed, end_request() uses req->hard_cur_sectors while
end_entire_request() uses req->hard_nr_sectors which I missed.

On 4/11/07, Rusty Russell <rusty@rustcorp.com.au> wrote:
> Hope that clarifies!

It does. Thanks Rusty :)

                                  Pekka
