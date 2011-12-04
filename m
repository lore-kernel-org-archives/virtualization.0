From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Sun, 04 Dec 2011 19:39:34 +0200
Message-ID: <1323020374.3256.5.camel@lappy>
References: <4ED4F30F.8000603@redhat.com> <1322669511.3985.8.camel@lappy>
	<87wrahrp0u.fsf@rustcorp.com.au> <20111201075847.GA5479@redhat.com>
	<1322726977.3259.3.camel@lappy> <20111201102640.GB8822@redhat.com>
	<87zkfbre9x.fsf@rustcorp.com.au> <1322913028.3782.4.camel@lappy>
	<4EDB5EF0.2010909@redhat.com> <1323000831.4205.4.camel@lappy>
	<20111204162221.GB22501@redhat.com> <1323020088.3256.3.camel@lappy>
	<4EDBAFC5.2010405@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4EDBAFC5.2010405@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@redhat.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2011-12-04 at 19:37 +0200, Avi Kivity wrote:
> On 12/04/2011 07:34 PM, Sasha Levin wrote:
> > > 
> > > I'm confused. didn't you see a bigger benefit for guest->host by
> > > switching indirect off?
> >
> > The 5% improvement is over the 'regular' indirect on, not over indirect
> > off. Sorry for the confusion there.
> >
> > I suggested this change regardless of the outcome of indirect descriptor
> > threshold discussion, since it would help anyways.
> 
> For net, this makes sense.  For block, it reduces the effective queue
> depth, so it's not a trivial change.  It probably makes sense there too,
> though.

It doesn't have to be limited at that number, anything above that can go
through the regular kmalloc() path.

-- 

Sasha.
