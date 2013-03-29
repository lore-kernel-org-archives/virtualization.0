From: Asias He <asias@redhat.com>
Subject: Re: [PATCH 0/2] virtio: console: add locking around control out-vq
Date: Fri, 29 Mar 2013 08:38:49 +0800
Message-ID: <20130329003849.GA23404@hj.localdomain>
References: <cover.1364469955.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1364469955.git.amit.shah@redhat.com>
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
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 28, 2013 at 04:58:31PM +0530, Amit Shah wrote:
> The in-vq operations were protected by a lock, but the out-vq
> operations were not.  This caused panics / errors as described in
> patch 2.  Fix that.

BTW, this looks suspicious. Why no lock here?

   static void remove_controlq_data(struct ports_device *portdev)
   {
           struct port_buffer *buf;
           unsigned int len;
   
           if (!use_multiport(portdev))
                   return;
   
           while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
                   free_buf(buf, true);
   
           while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
                   free_buf(buf, true);
   }




> The first patch renames the existing cvq_lock to c_ivq_lock to match
> c_ivq.  The second patch introduces the c_ovq_lock for the c_ovq.
> 
> Please apply.  I also believe this is a candidate for stable.
> 
> 
> Amit Shah (2):
>   virtio: console: rename cvq_lock to c_ivq_lock
>   virtio: console: add locking around c_ovq operations
> 
>  drivers/char/virtio_console.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> -- 
> 1.8.1.4
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 
Asias
