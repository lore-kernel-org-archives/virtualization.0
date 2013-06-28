From: Andy King <acking@vmware.com>
Subject: Re: [RFC 4/5] VSOCK: Introduce vhost-vsock.ko
Date: Thu, 27 Jun 2013 19:38:43 -0700 (PDT)
Message-ID: <1767234411.9934439.1372387123615.JavaMail.root__38420.9973308772$1372387140$gmane$org@vmware.com>
References: <1372320004-20502-1-git-send-email-asias@redhat.com>
	<1372320004-20502-5-git-send-email-asias@redhat.com>
	<20130627104246.GC20215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130627104246.GC20215@redhat.com>
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
Cc: kvm@vger.kernel.org, Dmitry Torokhov <dtor@vmware.com>, netdev@vger.kernel.org, Reilly Grant <grantr@vmware.com>, virtualization@lists.linux-foundation.org, Pekka Enberg <penberg@kernel.org>, Sasha Levin <sasha.levin@oracle.com>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Hi Michael,

> > +	u32 cid = VHOST_VSOCK_DEFAULT_HOST_CID;
> > +	return cid;
> > +}
> > +
> 
> Interesting. So all hosts in fact have the same CID?

"Host" here means the thing _below_ the VM.  Any process running on
the host OS can be addressed with cid 2.  Each VM gets its own cid.
So communication is always between VM x <-> host 2.  That makes for
easy lookup on the VM's part.  (Note that we further distinguish in
the VMCI transport between the hypervisor, specifically the VM's own
VMX, which is on cid 0, and the host on cid 2.)

Thanks!
- Andy
