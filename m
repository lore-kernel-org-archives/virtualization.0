From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtq questions
Date: Wed, 2 Oct 2019 15:52:51 +0100
Message-ID: <20191002145251.GD2710@work-vm>
References: <CAJfpegsGNoT4NUai-=HHkqOrmjgMb=4TDk79EgxDBCd8fxCGZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJfpegsGNoT4NUai-=HHkqOrmjgMb=4TDk79EgxDBCd8fxCGZA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* Miklos Szeredi (miklos@szeredi.hu) wrote:
> Looking at the ugly retry logic in virtiofs and have some questions.
> First one is, where do these features come from:
> 
> VIRTIO_F_RING_PACKED
> VIRTIO_RING_F_INDIRECT_DESC
> 
> I see that in virtiofs "packed" is off and "indirect" is on.  Is this
> guaranteed?

I think the xdindirect is coming from qemu's hw/virtio/virtio.h DEFINE_VIRTIO_COMMON_FEATURES
which has:
    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
                      VIRTIO_RING_F_INDIRECT_DESC, true), \

Dave

> Thanks,
> Miklos
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
