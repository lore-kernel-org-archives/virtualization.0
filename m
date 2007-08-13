From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH 0/2][KVM] guest time accounting
Date: Mon, 13 Aug 2007 16:15:42 +0200
Message-ID: <200708131615.42643.borntraeger__31904.7456411228$1187014793$gmane$org@de.ibm.com>
References: <46BC8B39.6050202@bull.net> <46C00FC1.1070306@qumranet.com>
	<46C012A8.2040908@bull.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C012A8.2040908@bull.net>
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
To: kvm-devel@lists.sourceforge.net
Cc: Laurent Vivier <Laurent.Vivier@bull.net>, cotte@de.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Am Montag, 13. August 2007 schrieb Laurent Vivier:
> > [copying Ingo and Rusty]

@Avi, seems that sourceforge is mangling the cc list?

> > 
> > The patches look good.  A couple of comments:
> > 
> > - perhaps the new fields should be guarded by a #ifdef CONFIG_HYPERVISOR
> > (selected by CONFIG_KVM)?  that way the (minor) additional overhead is
> > only incurred if it can possibly be used.  I imagine that our canine
> > cousin will want to use this as well.
> 
> There is also a CONFIG_VIRTUALIZATION and a CONFIG_VIRT_CPU_ACCOUNTING (from
> s390 and powerpc) Which one to use ?

CONFIG_VIRT_CPU_ACCOUNTING is used for the precise accouting of user,system, 
steal and irq time on these platforms and is not what you want for the on/off 
decision. 
> 
> I'm wondering if we can have a more accurate accounting:
> 
> - For the moment we add all system time since the previous entering to the
> VCPU to the guest time (and I guess there is some real system time in
> it ???) 
> - Perhaps we can sum nanoseconds spent in the VCPU and add it to cpustat
> when these ns are greater than 1 ms ? (I'm trying to make something in this 
way)

If you look at the patch I have posted some minutes ago, I use a method 
similar to irq_enter and irq_exit to separate real system time from guest 
time. 

> > - I think that there is per-task accounting of user time and system
> > time; that should be extended as well.
> it should be easy to do too...

We have to make sure that userspace doesnt break, but yes we should have a 
guest time for processes as well. 

Christian
