From: Amos Kong <akong@redhat.com>
Subject: Re: [PATCH 2/2] virtio-rng: fix stuck in catting hwrng attributes
Date: Sun, 14 Sep 2014 09:16:17 +0800
Message-ID: <20140914011617.GB1032@zen.redhat.com>
References: <1410340027-15373-1-git-send-email-akong@redhat.com>
	<1410340027-15373-3-git-send-email-akong@redhat.com>
	<20140911060838.GF19202@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140911060838.GF19202@grmbl.mre>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amit Shah <amit.shah@redhat.com>
Cc: herbert.xu@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Sep 11, 2014 at 11:38:38AM +0530, Amit Shah wrote:
> On (Wed) 10 Sep 2014 [17:07:07], Amos Kong wrote:
> > When I check hwrng attributes in sysfs, cat process always gets
> > stuck if guest has only 1 vcpu and uses a slow rng backend.
> > 
> > Currently we check if there is any tasks waiting to be run on
> > current cpu in rng_dev_read() by need_resched(). But need_resched()
> > doesn't work because rng_dev_read() is executing in user context.
> > 
> > This patch removed need_resched() and increase delay to 10 jiffies,
> > then other tasks can have chance to execute protected code.
> > Delaying 1 jiffy also works, but 10 jiffies is safer.

Hi Amit,
 
> I'd prefer two patches for this one: one to remove the need_resched()
> check, and the other to increase the timeout.

If Rusty agrees with this fix, I will respin to update the commitlog
with clear description and split the patches to 3.

Thanks for the review.
 
> Anyway,
> 
> Reviewed-by: Amit Shah <amit.shah@redhat.com>

--
                Amos.
