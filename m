From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH V2 RFC 9/9] virtio_scsi: verify if queue is broken after
	virtqueue_get_buf()
Date: Mon, 28 Oct 2013 09:59:04 +1030
Message-ID: <87y55egunz.fsf@rustcorp.com.au>
References: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1382628200-42956-10-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382628200-42956-10-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Heinz Graalfs <graalfs@linux.vnet.ibm.com> writes:
> If virtqueue_get_buf() returned with a NULL pointer avoid a possibly
> endless loop by checking for a broken virtqueue.
>
> Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

Yes, these look good.

Please just repost the first one, and I'll apply.

Thanks,
Rusty.
