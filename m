From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] virtio-ring: Use threshold for switching to indirect
	descriptors
Date: Sun, 04 Dec 2011 18:33:52 +0200
Message-ID: <4EDBA0F0.4000907@redhat.com>
References: <20111201075847.GA5479@redhat.com> <1322726977.3259.3.camel@lappy>
	<20111201102640.GB8822@redhat.com> <87zkfbre9x.fsf@rustcorp.com.au>
	<1322913028.3782.4.camel@lappy> <4EDB5EF0.2010909@redhat.com>
	<20111204120132.GB18758@redhat.com> <4EDB624A.3030403@redhat.com>
	<20111204151148.GA21851@redhat.com> <4EDB8EEB.4070309@redhat.com>
	<20111204160053.GA22501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111204160053.GA22501@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: markmc@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 12/04/2011 06:00 PM, Michael S. Tsirkin wrote:
> >  If you
> > copy descriptors, then it goes away.
>
> The avail ring could go away. used could if we make descriptors
> writeable. IIUC it was made RO in the hope that will make it
> easier for xen to adopt. Still relevant?

You mean RO from the consumer side?  Why can't Xen do that?

> > That does suck.  Are there issues in increasing the ring size?  Or
> > making it discontiguous?
>
> discontiguous ring is what indirect is, basically.

No, discontiguous is more cache and prefetch friendly.  With vmap(), the
code doesn't even change.


-- 
error compiling committee.c: too many arguments to function
