From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V4 0/2] tcm_vhost hotplug
Date: Mon, 25 Mar 2013 16:20:09 +0800
Message-ID: <20130325082009.GC20435@hj.localdomain>
References: <1363930745-7520-1-git-send-email-asias@redhat.com>
	<20130324152054.GC8657@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130324152054.GC8657@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, Mar 24, 2013 at 05:20:54PM +0200, Michael S. Tsirkin wrote:
> On Fri, Mar 22, 2013 at 01:39:03PM +0800, Asias He wrote:
> > Asias He (2):
> >   tcm_vhost: Introduce tcm_vhost_check_feature()
> >   tcm_vhost: Add hotplug/hotunplug support
> 
> So this work should stay out of tree until we have
> 2 users for vhost-scsi, but I sent some comment to
> help you make progress.

Actually, I do not think the real reason you want to blcok/delay this
is that there is only one user. I believe the real reason is simply that
qemu is not using it. If there were already 2 users other than qemu
(qemu is still not using it), what would you say, you want 3 users of
this? Would you say the same 2 user thing, if a feature is only used by
qemu and other users are not using it?

Also, can you comment on Paolo's comment in the other thread.
"""
Il 19/03/2013 14:45, Michael S. Tsirkin ha scritto:
> On Tue, Mar 19, 2013 at 10:36:42AM +0100, Paolo Bonzini wrote:                                                                       
>> Il 18/03/2013 22:53, Michael S. Tsirkin ha scritto:                                                                                 
>>> Sorry, no, I'd prefer we get userspace support in qemu in first.                                                                   
>>> If there's only a single user for this driver (kvmtool),                                                                           
>>> then it was a mistake to merge it, the right thing would be to
>>> freeze it                                                           
>>> and look at whether we can drop it completely.                                                                                     
>>                                                                                                                                     
>> I'm still not sure why this matters for this patch, since it does not                                                               
>> change the userspace ABI.                                                                                                           
>                                                                                                                                      
> It enables a new feature bit.                                                                                                        

How does that matter if userspace is not supposed to do anything special
with that bit?

Paolo
"""

> >  drivers/vhost/tcm_vhost.c | 224 ++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/vhost/tcm_vhost.h |  10 +++
> >  2 files changed, 229 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 1.8.1.4

-- 
Asias
