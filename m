From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: vhost net: performance with ping benchmark
Date: Thu, 27 Aug 2009 19:00:52 +0300
Message-ID: <20090827160052.GA23727__29532.0282959894$1251389041$gmane$org@redhat.com>
References: <20090824081240.GA3415@redhat.com> <4A936525.5030300@redhat.com>
	<200908251434.41402.arnd@arndb.de>
	<200908261704.45298.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908261704.45298.rusty@rustcorp.com.au>
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
Cc: Mark McLoughlin <markmc@redhat.com>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 26, 2009 at 05:04:44PM +0930, Rusty Russell wrote:
> On Tue, 25 Aug 2009 10:04:41 pm Arnd Bergmann wrote:
> > On Tuesday 25 August 2009, Avi Kivity wrote:
> > > On 08/25/2009 05:22 AM, Anthony Liguori wrote:
> > > >
> > > > I think 2.6.32 is pushing it. 
> > > 
> > > 2.6.32 is pushing it, but we need to push it.
> > 
> > Agreed.
> 
> Get real.  It's not happening.

linux-next should be ok though?  Can you put patches there without
targeting 2.6.32?

> We need migration completely solved and tested.  I want to see all the
> features supported, including indirect descs and GSO.
> 
> If this wasn't a new userspace ABI, I'd be all for throwing it in as
> experimental ASAP.
> 
> Rusty.
