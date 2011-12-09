From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Fri, 09 Dec 2011 16:03:10 +1030
Message-ID: <87obvifgx5.fsf__46105.5352156565$1323426775$gmane$org@rustcorp.com.au>
References: <87zkfbre9x.fsf@rustcorp.com.au> <1322913028.3782.4.camel@lappy>
	<4EDB5EF0.2010909@redhat.com> <1323000831.4205.4.camel@lappy>
	<20111204162221.GB22501@redhat.com>
	<1323020088.3256.3.camel@lappy> <4EDBAFC5.2010405@redhat.com>
	<1323020374.3256.5.camel@lappy> <1323023039.3256.7.camel@lappy>
	<1323266565.4009.10.camel@lappy>
	<20111207154816.GA23845@redhat.com>
	<87r50fgzyj.fsf@rustcorp.com.au> <1323340668.3904.21.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323340668.3904.21.camel@lappy>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 08 Dec 2011 12:37:48 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> On Thu, 2011-12-08 at 20:14 +1030, Rusty Russell wrote:
> > On Wed, 7 Dec 2011 17:48:17 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Dec 07, 2011 at 04:02:45PM +0200, Sasha Levin wrote:
> > > > On Sun, 2011-12-04 at 20:23 +0200, Sasha Levin wrote:
> > > > 
> > > > [snip]
> > > > 
> > > > Rusty, Michael, does the below looks a reasonable optimization for you?
> > > 
> > > OK overall but a bit hard to say for sure as it looks pretty incomplete ...
> > 
> > A static threshold is very hackish; we need to either initialize it to
> > a proven-good value (since noone will ever change it) or be cleverer.
> 
> I'll better wait to see how the threshold issue is resolved, and
> possibly do it as a dynamic value which depends on the threshold.
> 
> I doubt theres one magic value which would work for all.

Sure, but if it's generally better than the current value, I'll apply it.

Cheers,
Rusty.
