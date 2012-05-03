From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 1/2] virtio-blk: Fix hot-unplug race in remove method
Date: Thu, 3 May 2012 07:02:01 +0200
Message-ID: <CA+1xoqcKQmSQxvUR6syvseUow4AfcnKmDODW=j6t6gejmSi4NA__17272.0495182604$1336021353$gmane$org@mail.gmail.com>
References: <1336011592-24889-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1336011592-24889-1-git-send-email-asias@redhat.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, May 3, 2012 at 4:19 AM, Asias He <asias@redhat.com> wrote:
> @@ -190,6 +194,7 @@ static void do_virtblk_request(struct request_queue *=
q)
>
> =A0 =A0 =A0 =A0while ((req =3D blk_peek_request(q)) !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG_ON(req->nr_phys_segments + 2 > vblk->s=
g_elems);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vblk->req_in_flight++;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* If this request fails, stop queue and w=
ait for something to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 finish to restart it. */

This is being increased before we know if the request will actually be
sent, so if do_req() fails afterwards, req_in_flight would be
increased but the request will never be sent.

Which means we won't be able to unplug the device ever.
