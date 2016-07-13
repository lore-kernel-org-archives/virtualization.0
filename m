From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH] virtio: Return correct errno for function init_vq's
	failure
Date: Wed, 13 Jul 2016 14:05:40 +0200
Message-ID: <20160713140540.78c9ab01.cornelia.huck@de.ibm.com>
References: <1466993358-12064-1-git-send-email-mnghuan@gmail.com>
	<20160706111832.5d4d6f43.cornelia.huck@de.ibm.com>
	<20160713115400.GA16403@MinfeideMacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160713115400.GA16403@MinfeideMacBook-Pro.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Minfei Huang <mnghuan@gmail.com>
Cc: Minfei Huang <minfei.hmf@alibaba-inc.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 13 Jul 2016 19:54:00 +0800
Minfei Huang <mnghuan@gmail.com> wrote:

> On 07/06/16 at 11:18P, Cornelia Huck wrote:
> > On Mon, 27 Jun 2016 10:09:18 +0800
> > Minfei Huang <mnghuan@gmail.com> wrote:
> > 
> > > The error number -ENOENT or 0 will be returned, if we can not allocate
> > > more memory in function init_vq. If host can support multiple virtual
> > > queues, and we fails to allocate necessary memory structures for vq,
> > > kernel may crash due to incorrect returning.
> > > 
> > > To fix it, kernel will return correct value in init_vq.
> > The error handling in this function looks horrible.
> > 
> > When mq was introduced, init_vq started mixing up several things:
> > - The mq feature is not available - which is not an error, and
> > therefore should not have any influence on the return code.
> > - One of the several memory allocations failed - only ->vqs gets
> > special treatment, however.
> > - The ->find_vqs callback failed.
> 
> Yep. And without this patch, it is silent for boot failure. I think it
> makes sense to let user notify about this failure.

Agreed.

> 
> > 
> > Your patch fixes the code, but it is still very convoluted due to the
> > temporary arrays.
> > 
> > May it be worthwile to introduce a helper for setting up the virtqueues
> > where all virtqueues are essentially the same and just get a
> > consecutive number? Michael?
> > 
> 
> Hmm, How about refactor this function to make it more readable, since we
> do a lot of work in it.
> 
> I will post an update to refactor this function.

Anything to make this more readable probably helps :)
