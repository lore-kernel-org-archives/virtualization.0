From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V3 0/2] tcm_vhost hotplug/hotunplug support
Date: Tue, 19 Mar 2013 15:45:52 +0200
Message-ID: <20130319134552.GB12913@redhat.com>
References: <1363056339-6061-1-git-send-email-asias@redhat.com>
	<1363643172.3156.62.camel@haakon2.linux-iscsi.org>
	<20130318215350.GA21091@redhat.com> <514831AA.4030500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <514831AA.4030500@redhat.com>
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

On Tue, Mar 19, 2013 at 10:36:42AM +0100, Paolo Bonzini wrote:
> Il 18/03/2013 22:53, Michael S. Tsirkin ha scritto:
> > Sorry, no, I'd prefer we get userspace support in qemu in first.
> > If there's only a single user for this driver (kvmtool),
> > then it was a mistake to merge it, the right thing would be to freeze it
> > and look at whether we can drop it completely.
> 
> I'm still not sure why this matters for this patch, since it does not
> change the userspace ABI.
> 
> Paolo

It enables a new feature bit.

> > I really don't want this, I hope it will be merged and all will
> > be shiny, but I think it's wrong to rush in more code,
> > we have some time before the next merge window.
