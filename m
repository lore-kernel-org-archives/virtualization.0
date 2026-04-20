Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8BD3C3426
	for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776712656; cv=pass; b=rmbjRSlRjDLlckQq6BllJkhWG/xoPj5Y5qJ7nBlpXV9uztr6ZVcxGq6nvdKro3POlEItJx5Duv6i7H3guHHbLx9XLnwGmlS75zVTie6nlGqY/Ls6F3WMbd/NTWImpk0IYvNCBQt0cUvN0C9wuyR+YRKh33Y4ZIRwsJRt3ZpWSe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776712656; c=relaxed/simple;
	bh=e/y0Pfu4Dq1Q5qmvf4rLxAev2cdUMuF47zxeKhZGvt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8sv3m1pl7DUFXVvUCW25G7YMUIWV0STRcUsvTY8RnAnsflxXghz2TElRnOT/5REKd8a64nUYUMIROXveFjaukApwhzk9twTrJP2t9b7z5qR0Rx9VX7ISL5frz6UYcj1rX+A5Si6clIt5m/04TXbIcindAbzK1/PFEwUhx+IHNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ag6CrWFA; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag6CrWFA"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-652fcd5a6d7so3923684d50.2
        for <virtualization@lists.linux.dev>; Mon, 20 Apr 2026 12:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776712654; cv=none;
        d=google.com; s=arc-20240605;
        b=f7/mLSrvXzu21lTh0jfnFmQ1W4aa8Yne/IFBlqFcIdBa6c2hfDPUe6bKRQ70AsSMcj
         OR/xyob66yKtdGfakFYAET/itfgIInCxrwz0v7e4FXIJiMgH0AaSmTG/PbdvC9Nl9qwP
         ZH+Y5rFvy8kp1oR/NxDxW2IQ/CEGdVkCBv/m5ZFLTFhrosFDFQkbSiSRQ8XO0iq0zTV6
         Q5KCyEI0qwhX1vN49NIbwY59QhVA7iiHwmmFDSAyH5oFrA9sN5lfkJ9eFrhrcks4kUFB
         PXbaHvdWLrnq7wIFee4DLsuw87kP6m2SY3GxPKXH1q3gHKtoUlKbUa+28cbDMyfQo7A8
         X/FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LqId3eMMe5rDOg5MnTzpXj8ZIYTviI3UDAXasv1bsS0=;
        fh=uTwhS3pyzcgUJjYa/bTgiGjp0tJ8gAKzbebnHwCI40A=;
        b=Hl7bMkAqx5/1NBahOkAhMxplBM7YpvVeCP/9UJzoBsPykDOtMovmk5R79AJ7zTsJEv
         cE8vRQWFSgRHA8r/CG2CfWevjlKNL90t9FoPAZYSfXhAlQSliXLsOcN6BlW0sj3eWfYT
         h8i+jkYfKdSrm4azTf7Ye4yqP+1CTX4rpM3ZWI+C93ACZsDoaim/uRhEcpcxKb0M1g1U
         qmfOIc++uroNVe5mzER58cMJIX9POrhs/D7DlYIS7P7+N8D9Ltg7ztBa0BDP9/DdnwRU
         CPQnuFF46in3/q7Z54YMaKkDI3wBQy6vnDJ+P6AQjNNdvwDn/qJsBQcd1F7cMribdhdA
         i+hw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776712654; x=1777317454; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqId3eMMe5rDOg5MnTzpXj8ZIYTviI3UDAXasv1bsS0=;
        b=ag6CrWFAVEjaiJ/w5wNzeL5xjh9v5QG+Pw1R7h+YBWvWKLtNMiuKZwxUF2q0vcej7p
         fViYkKvYHnd4goG3QE+1yNAG/w4tu5PTgH2EfvRvg9kwwqDQ6OnTrPZnsjAvt+K0g0bS
         l1Iw9BfGpbhtLlCGyM2ghNfntcjsjhzrJhDR+zSdmdER2WswhyP1QcTlD7qleaDeWNMG
         izAFWbbaiNE61U0k/lAVfPUqzfYlNP1oCP7ZTKF27Pnl1BnJ9UrpqumGAJGoOsSDBS8P
         qx7FjhysmfYDpO7nkjTRXvV4pROL2jzC1JG5M+dzjHtfAJ8JdmV53h1zm8+n94QyUdYM
         HUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776712654; x=1777317454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LqId3eMMe5rDOg5MnTzpXj8ZIYTviI3UDAXasv1bsS0=;
        b=HBNCIrh6IXQZJfBcZ2LTu413XpIfAQzd2STOo4D9+vot2tO5Nkiu/mBKnylBsx6oik
         YRXw+8UcaZBAZloUXFJSOLytDoQoKKyZWVmB8Y0trITLzzQYay2UzUNQSw6+mYIqpTuS
         wDWGpE19t2UQK4ENQty7DkXkQ1p2t2oqW3TM26lRbfYuCl/tkqgk3C3jbrtGQ8kskOgn
         GMuC5D2Pioh2p41p9UtGjcwoiRLg+EbtPyyMF8GELDVgqDsBwDp++ZFOqTQMyyah0Ruk
         xaJ8NYbvKeBRY9Sj01ZeaUGQEBi2BZBifAwcd+d4EuxAo7hsfo6N5kEFBlqQinw9xK0N
         /+SA==
X-Forwarded-Encrypted: i=1; AFNElJ+POdAv2gnrS4sNQbm/qEMlvSi9eBHVVgKNrqU6Pr+y8ATYcGjR4+gnXnLQKvsBu0uA4HQDVRNrabkxfY9aFA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzW0t6o0vXa3zpPzH6bL+cyJBzeYEr5WBVzF5g9UlI/Yab0eNGZ
	pqi48cZVQltai7fz0cLInGkp/3SB75R2NI3V9AsyZ3HxocOPJA3OEfWi4WPg/Cwlibf/gaCY/uu
	tqjw9T4aRlm8l6VEg6/wAtM1Ha9Hxl2s=
X-Gm-Gg: AeBDietRkhrOBoEBiOfuNxbTZlE8bqjdQozlJyDn6VShrFdXh12CCql5mA64Asmdz4o
	ICVMjvWPSA5Ki5TO0h76WCvcRDx8KlP/IEq1IKlFeLhg+83DFQ2t+jlZOQdm7upRH7CdShzJYPJ
	aRFykS1GNz/qp9SPB1sy9uwqxz8Y24EgbfIMUlcIB+wjWsYuoZoKX+avVh/B51iZynUhWjoleDa
	qq1oXh9sUNRl23qIHMLA3+uYoRb0jQTv6yvzPbEZB97MCRm0zadAyXjZBnC2IwxqaAWNWEWp6Lp
	CVec9JZ6GZFgQp6sSWrIpUGFf0Lqf5P2aSMozLCCLVTgX/5SUvrpXBDHYQrrgD7oXQgV7NhuA3E
	ItA==
X-Received: by 2002:a05:690e:4141:b0:650:2ff9:d656 with SMTP id
 956f58d0204a3-653108b5176mr14907504d50.29.1776712653576; Mon, 20 Apr 2026
 12:17:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260418000138.1848813-1-michael.bommarito@gmail.com>
In-Reply-To: <20260418000138.1848813-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Apr 2026 15:17:20 -0400
X-Gm-Features: AQROBzB7p2eqNslJGxxV9DmwoYgd1f6Ag_8dEyj71H75g_Ar-pjlqehIUD42okY
Message-ID: <CABBYNZKP-Rwumw0c7FHEsL5e6XpFZCBA-O2avNujtYgRHeVZhA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: virtio_bt: clamp rx length before skb_put
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Soenke Huster <soenke.huster@eknoes.de>, 
	"Michael S . Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Apr 17, 2026 at 8:01=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> virtbt_rx_work() calls skb_put(skb, len) where len comes directly
> from virtqueue_get_buf() with no validation against the skb we
> posted.  The RX skb is allocated as alloc_skb(1000) in
> virtbt_add_inbuf().  A malicious or buggy virtio-bt backend that
> reports used.len larger than the skb's tailroom causes skb_put() to
> call skb_over_panic() in net/core/skbuff.c, which triggers
> BUG() and panics the guest.
>
> Reproduced on a QEMU 9.0 whose virtio-bt backend reports
> used.len =3D 4096 into a 1000-byte rx skb:
>
>   skbuff: skb_over_panic: text:ffffffff83958e84 len:4096 put:4096
>       head:ffff88800c071000 data:ffff88800c071000 tail:0x1000
>       end:0x6c0 dev:<NULL>
>   ------------[ cut here ]------------
>   kernel BUG at net/core/skbuff.c:214!
>   Call Trace:
>    skb_panic+0x160/0x162
>    skb_put.cold+0x31/0x31
>    virtbt_rx_work+0x94/0x250
>    process_one_work+0x80d/0x1510
>    worker_thread+0x4af/0xd20
>    kthread+0x2cc/0x3a0
>
> Reject any len that exceeds skb_tailroom().  Drop the skb on the
> error path; virtbt_add_inbuf() reposts a fresh one for the next
> iteration.  With the check in place the same harness runs without
> BUG(); the driver logs "rx reply len %u exceeds skb tailroom %u"
> and the device keeps running.
>
> Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in=
 USB transport layer"),
> which hardened the USB 9p transport against unchecked device-reported len=
gth.
>
> Fixes: 160fbcf3bfb9 ("Bluetooth: virtio_bt: Use skb_put to set length")
> Cc: stable@vger.kernel.org
> Cc: Soenke Huster <soenke.huster@eknoes.de>
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7
> ---
>  drivers/bluetooth/virtio_bt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.=
c
> index 76d61af8a275..157e68b6e75f 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -227,8 +227,15 @@ static void virtbt_rx_work(struct work_struct *work)
>         if (!skb)
>                 return;
>
> -       skb_put(skb, len);
> -       virtbt_rx_handle(vbt, skb);
> +       if (len > skb_tailroom(skb)) {
> +               bt_dev_err(vbt->hdev,
> +                          "rx reply len %u exceeds skb tailroom %u\n",
> +                          len, skb_tailroom(skb));
> +               kfree_skb(skb);
> +       } else {
> +               skb_put(skb, len);
> +               virtbt_rx_handle(vbt, skb);
> +       }
>
>         if (virtbt_add_inbuf(vbt) < 0)
>                 return;
> --
> 2.53.0

https://sashiko.dev/#/patchset/20260418000138.1848813-1-michael.bommarito%4=
0gmail.com

All seem like valid comments to me, first one is odd to me thought,
never would have though that skb_tailroom wouldn't be enough to check
if using `skb_put` is safe.

--=20
Luiz Augusto von Dentz
