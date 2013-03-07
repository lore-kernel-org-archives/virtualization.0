From: Asias He <asias@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Thu, 7 Mar 2013 08:36:10 +0800
Message-ID: <20130307003609.GC8785@hj.localdomain>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<20130305121125.GA823@redhat.com>
	<20130306012811.GA20372@hj.localdomain>
	<51377FDB.1080605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51377FDB.1080605@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2013 at 06:41:47PM +0100, Paolo Bonzini wrote:
> Il 06/03/2013 02:28, Asias He ha scritto:
> >> > This can queue up quite a bit of memory if the handler thread
> >> > is delayed, no? Can we limit the # of outstanding events?
> >> > Will guest recover from a missed event?
> > Hmm, good point. Will limit the number. The size of 'struct
> > tcm_vhost_evt' is around 20 bytes. So if we limit it to 128, it is ~2.5K
> > of memory.
> > 
> > Paolo, if we limit the number of outstanding events and set
> > vs->vs_events_dropped, the guest will recover from a missed event, right?
> 
> Yes.  At least it should (it doesn't yet).

Ok, thanks.

> Paolo
> 

-- 
Asias
