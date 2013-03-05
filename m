From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] tcm_vhost: Add hotplug/hotunplug support
Date: Tue, 5 Mar 2013 16:34:17 +0200
Message-ID: <20130305143416.GG2256@redhat.com>
References: <1362475027-12018-1-git-send-email-asias@redhat.com>
	<20130305121125.GA823@redhat.com> <5135F150.1060206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5135F150.1060206@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 05, 2013 at 02:21:20PM +0100, Paolo Bonzini wrote:
> Il 05/03/2013 13:11, Michael S. Tsirkin ha scritto:
> >> > +
> >> > +	struct vhost_work vs_event_work; /* evt injection work item */
> >> > +	struct llist_head vs_event_list; /* evt injection queue */
> >> > +
> >> > +	bool vs_events_dropped;
> > Documentation pls.
> > Also - how is this handled during migration?
> 
> Migration is not supported by vhost-scsi but yes, we would need to
> retrieve this bit.
> 
> Paolo

Well at the moment nothing is supported as there's no userspace
upstream :(

> > Don't we need a way for userspace to retrieve this bit?
> > 
