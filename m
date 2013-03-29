From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/2] virtio: console: add locking around control out-vq
Date: Fri, 29 Mar 2013 16:05:00 +0530
Message-ID: <20130329103500.GC14019@amit.redhat.com>
References: <cover.1364469955.git.amit.shah@redhat.com>
	<20130329003849.GA23404@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130329003849.GA23404@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 29 Mar 2013 [08:38:49], Asias He wrote:
> On Thu, Mar 28, 2013 at 04:58:31PM +0530, Amit Shah wrote:
> > The in-vq operations were protected by a lock, but the out-vq
> > operations were not.  This caused panics / errors as described in
> > patch 2.  Fix that.
> 
> BTW, this looks suspicious. Why no lock here?
> 
>    static void remove_controlq_data(struct ports_device *portdev)
>    {
>            struct port_buffer *buf;
>            unsigned int len;
>    
>            if (!use_multiport(portdev))
>                    return;
>    
>            while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
>                    free_buf(buf, true);
>    
>            while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
>                    free_buf(buf, true);
>    }

Since this is c_ivq, you mean why can't the host be queueing up data
in the vq while we're removing the buffers from the vq.

This function is called from two places, virtcons_remove() and
virtcons_freeze(). In both the cases, everything is set up so the host
can't send anything: vdev->config->reset() ensures that.

Is there something else that can be happening?

		Amit
