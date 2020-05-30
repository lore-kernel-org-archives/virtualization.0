From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v3] virtio_vsock: Fix race condition in
 virtio_transport_recv_pkt()
Date: Sat, 30 May 2020 12:40:42 +0200
Message-ID: <7edeff0b-2dd8-aeae-aa96-73c98d581ece@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Language: en-GB
Sender: kernel-janitors-owner@vger.kernel.org
To: Jia He <justin.he@arm.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Kaly Xin <Kaly.Xin@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> This fixes it by checking sk->sk_shutdown(suggested by Stefano) after
> lock_sock since sk->sk_shutdown is set to SHUTDOWN_MASK under the
> protection of lock_sock_nested.

How do you think about a wording variant like the following?

  Thus check the data structure member =E2=80=9Csk_shutdown=E2=80=9D (sugg=
ested by Stefano)
  after a call of the function =E2=80=9Clock_sock=E2=80=9D since this fiel=
d is set to
  =E2=80=9CSHUTDOWN_MASK=E2=80=9D under the protection of =E2=80=9Clock_so=
ck_nested=E2=80=9D.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus
