From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: vhost net: performance with ping benchmark
Date: Wed, 26 Aug 2009 17:04:44 +0930
Message-ID: <200908261704.45298.rusty__32903.7797208459$1251272155$gmane$org@rustcorp.com.au>
References: <20090824081240.GA3415@redhat.com> <4A936525.5030300@redhat.com>
	<200908251434.41402.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200908251434.41402.arnd@arndb.de>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark McLoughlin <markmc@redhat.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 25 Aug 2009 10:04:41 pm Arnd Bergmann wrote:
> On Tuesday 25 August 2009, Avi Kivity wrote:
> > On 08/25/2009 05:22 AM, Anthony Liguori wrote:
> > >
> > > I think 2.6.32 is pushing it. 
> > 
> > 2.6.32 is pushing it, but we need to push it.
> 
> Agreed.

Get real.  It's not happening.

We need migration completely solved and tested.  I want to see all the
features supported, including indirect descs and GSO.

If this wasn't a new userspace ABI, I'd be all for throwing it in as
experimental ASAP.

Rusty.
