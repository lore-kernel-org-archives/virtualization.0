From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest/host benchmarks.
Date: Sat, 09 Jun 2007 20:43:44 +1000
Message-ID: <1181385825.11961.28.camel@localhost.localdomain>
References: <Pine.LNX.4.60.0706011704240.786@rtl14.hofr.at>
	<1180780059.9228.72.camel@localhost.localdomain>
	<Pine.LNX.4.60.0706080908100.811@rtl14.hofr.at>
	<1181362602.6025.72.camel@localhost.localdomain>
	<Pine.LNX.4.60.0706090628570.395@rtl14.hofr.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0706090628570.395@rtl14.hofr.at>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Jens Axboe <jens.axboe@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2007-06-09 at 06:44 +0200, Nicholas Mc Guire wrote:
> so the file issue is most likely a memory exhaustion effect on the guest 

Right, I usually run w/ 512M of ram per guest, so I haven't noticed.

> we still are checking things related to the absolute values reported - not 
> yet convinced that timing is that correct on the guest.

It's possible, which is why virtbench runs external to the guest.  I
never trust anyone's non-hardware clocks 8)

> > This can be optimized by enhancing the switcher itself to walk the guest
> > page tables and reflect is straight back into the guest if it's not
> > mapped there.  This shouldn't actually be too hard, but I wonder if it's
> > worth the complexity...
> >
> Even if it were it should not go into lguest - the really nice thing about 
> it is that one can actually understand it !

I agree, but I can probably do this in under 50 lines.  As you say, not
worth it if it doesn't hurt real applications.

Thanks, and thanks for the kind words about lguest!
Rusty.
