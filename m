From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio: Don't access index after unregister.
Date: Fri, 09 Nov 2012 14:54:50 +1030
Message-ID: <877gpv2yjx.fsf@rustcorp.com.au>
References: <1352371427-32363-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1352371427-32363-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cornelia Huck <cornelia.huck@de.ibm.com> writes:
> Virtio wants to release used indices after the corresponding
> virtio device has been unregistered. However, virtio does not
> hold an extra reference, giving up its last reference with
> device_unregister(), making accessing dev->index afterwards
> invalid.
>
> I actually saw problems when testing my (not-yet-merged)
> virtio-ccw code:
>
> - device_add virtio-net,id=xxx
> -> creates device virtio<n> with n>0
>
> - device_del xxx
> -> deletes virtio<n>, but calls ida_simple_remove with an
>    index of 0
>
> - device_add virtio-net,id=xxx
> -> tries to add virtio0, which is still in use...
>
> So let's save the index we want to release before calling
> device_unregister().

Great catch!  I've add a CC:stable.

Applied,
Rusty.
