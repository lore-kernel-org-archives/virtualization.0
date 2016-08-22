From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] CodingStyle: add some more error handling guidelines
Date: Mon, 22 Aug 2016 21:39:35 +0300
Message-ID: <20160822213743-mutt-send-email-mst__10745.3885757879$1471891187$gmane$org@kernel.org>
References: <1471874251-7721-1-git-send-email-mst@redhat.com>
	<20160822081617.386db8cd@lwn.net>
	<20160822174355-mutt-send-email-mst@kernel.org>
	<20160822183140.GE4129@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20160822183140.GE4129@mwanda>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 22, 2016 at 09:31:40PM +0300, Dan Carpenter wrote:
> 
> vhost_dev_set_owner() is an example of why come-from labels are
> bad style.
> 
> devel/drivers/vhost/vhost.c
>    473  /* Caller should have device mutex */
>    474  long vhost_dev_set_owner(struct vhost_dev *dev)
>    475  {
>    476          struct task_struct *worker;
>    477          int err;
>    478  
>    479          /* Is there an owner already? */
>    480          if (vhost_dev_has_owner(dev)) {
>    481                  err = -EBUSY;
>    482                  goto err_mm;
> 
> What does goto err_mm do?  It's actually a do-nothing goto.  It would
> be easier to read as a direct return.  Why is it called err_mm?  Because
> originally the condition was:
> 
> 	if (dev->mm) {
> 		err = -EBUSY;
> 		goto err_mm;
> 	}
> 
> We've changed the code but didn't update the label so it's slightly
> confusing unless you know how vhost_dev_has_owner() is implemented.
> 
>    483          }
>    484  
>    485          /* No owner, become one */
>    486          dev->mm = get_task_mm(current);
>    487          worker = kthread_create(vhost_worker, dev, "vhost-%d", current->pid);
>    488          if (IS_ERR(worker)) {
>    489                  err = PTR_ERR(worker);
>    490                  goto err_worker;
>    491          }
>    492  
>    493          dev->worker = worker;
>    494          wake_up_process(worker);        /* avoid contributing to loadavg */
>    495  
>    496          err = vhost_attach_cgroups(dev);
>    497          if (err)
>    498                  goto err_cgroup;
>    499  
>    500          err = vhost_dev_alloc_iovecs(dev);
>    501          if (err)
>    502                  goto err_cgroup;
> 
> This name doesn't make sense because it's a come-from label which is
> used twice.  Some people do:
> 
> 		if (err)
> 			goto err_iovecs;
> 
>    503  
>    504          return 0;


Right and the current CodingStyle text seems to discourage this.

> Then they add two labels here:
> 
> 	err_iovecs:
> 	err_cgroup:
> 		kthread_stop(worker);

Definitely good points above, I'll fix them up.


> But if you base the label name on the label location then it makes
> sense.  goto stop_kthread;  goto err_mmput;.
> 
>    505  err_cgroup:
>    506          kthread_stop(worker);
>    507          dev->worker = NULL;
>    508  err_worker:
>    509          if (dev->mm)
>    510                  mmput(dev->mm);
>    511          dev->mm = NULL;
>    512  err_mm:
>    513          return err;
>    514  }
> 
> regards,
> dan carpenter

OK, I'll consider this, thanks!

-- 
MST
