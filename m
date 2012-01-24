From: Joe Perches <joe@perches.com>
Subject: Re: [Xen-devel] [PATCH] include/checkpatch: Prefer __scanf to
	__attribute__((format(scanf, ...)
Date: Mon, 23 Jan 2012 18:00:29 -0800
Message-ID: <1327370429.20805.4.camel@joe2Laptop>
References: <2cf7ddd75001233e79e928c4dcfae6768af5790c.1327103792.git.joe@perches.com>
	<20120124014717.GA24204@andromeda.dapyr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120124014717.GA24204@andromeda.dapyr.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andy Whitcroft <apw@canonical.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2012-01-23 at 21:47 -0400, Konrad Rzeszutek Wilk wrote:
> On Fri, Jan 20, 2012 at 04:01:12PM -0800, Joe Perches wrote:
> > It's equivalent to __printf, so prefer __scanf.
> So ... looking at this patch it just seems to macro-fy the
> __printf and __scanf attributes.

It's just for __scanf.  The __printf change is just
a neatening/spacing change.

> Is this required to make
> cleanpatch.pl work easier?

No.  It's a trivial symmetry patch added to
make fewer uses of __attribute__((format(...)
similar to the __printf commit from awhile ago.

commit b9075fa968a0a4347aef35e235e2995c0e57dddd

> And there is also some checkpatch.pl features. Should that part
> be in a seperate patch?

I think it's OK to do the whole thing at once.
