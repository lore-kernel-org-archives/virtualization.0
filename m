From: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH] virtio-balloon: Avoid using the word 'report' when
 referring to free page hinting
Date: Wed, 15 Apr 2020 11:33:50 -0700
Message-ID: <CAKgT0UdVA48iUzd45tG-S-Md8Cb4S90aztcUgs4H5sLX-W9XkA@mail.gmail.com>
References: <20200415174318.13597.99753.stgit@localhost.localdomain>
 <30194715-bd6d-42df-2de0-6d54ad5a1136@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <30194715-bd6d-42df-2de0-6d54ad5a1136@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 15, 2020 at 10:46 AM David Hildenbrand <david@redhat.com> wrote:
> Can we also change the comment of
>
> #define VIRTIO_BALLOON_F_FREE_PAGE_HINT  /* VQ to report free pages */
>
> ?
>
> Thanks!

No problem. I will update and submit a v2.

Thanks.

- Alex
