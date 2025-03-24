Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED9F194AD5
	for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846039; cv=none; b=l0L4CYP5bn0/GaLi5tg6Y385R09auwBSjWIoP9yfMRc0a235wqJ3roP+dWFC8Y5DrVaHUvotbOiVsS55Enfgfp+NImJblXLmqTCtNet3p6qgio1U5W1av28ZOIuRwcF/BbjFEjxu/9MuRZZhFc0TlaReI+BKf4KwVbweetnWewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846039; c=relaxed/simple;
	bh=u5NQ/BAm881tOnqIxN0/hFBR2wZjfr8cxBjCMGnGSlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a70WOob7Pizhju2M4GBR+70z3q0kM0BMZUrUKVz6x6XjaLDypPAqn+Lx5HhoLIy9l2cJkcRLrENxq5siRa+W2X83lMs23GJGuRcHZl1QckHmRXyJ+q8WLNDgOxmpu6MWfL1+hekJ6lwTAVvRI4j05xNtnnwds+GqIiVMklUoIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jroVkakA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jroVkakA"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2260202c2a1so9770545ad.3
        for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 12:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742846037; x=1743450837; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NINTTnuRREaCij9WQdNsTWv0nTZM+LnALUAf/adBLFU=;
        b=jroVkakA9ONrVOua4kXxFQqQazuVNV3F+MZIanZCyJvdPE/04AI93kz940ZNLpaT1E
         ZevVJ3nzrMvvoTWBbCJ7fQkBEkUdGrvuVdx97+7jPc+LvKapGxAKHx2YtKMeKL27ymjd
         mkuLnS7pQDoZsoH2AuWDGkbT/GC0aOihZMI4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846037; x=1743450837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NINTTnuRREaCij9WQdNsTWv0nTZM+LnALUAf/adBLFU=;
        b=MeacggR97XRwA5lofh4JRE89Q5gHd2fC1fNB5BMcqD6WVljgx1S9PDa33Y9W+9715G
         BGP8EHiysk5tdK2oEYIb4wvjdShmz01D4we9imqgif4snQ9Z7f6vEATg2JvGhuw7EL3R
         87ZRpgT9xyDbQJ+31NeB9usc7Bh90OcW7xdpXNlZj3wqzxEWwMugJ33jjXClmpcldj1I
         UU/jls9PLXJZbyhcnfk5idhwGiz8Q4vv7+KoFLEe71oIeIjxZa+YaxzzWgteBXsF2Js+
         2wi2ewI+4QzOkQzKjX5VMGOemC8snbkLsY00Lnt1uV6gtDTMU8xKMkdk21lnCT4j0Sqs
         ksIg==
X-Forwarded-Encrypted: i=1; AJvYcCX0f9Kh4Cs9CFNUj9kVy1Rhw8DQkxRq/gBIRSeCWBYnVsGeW5SCOngHihO89Bf6BPsn3xujZZkF0waElFZ/0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwbegipCyHJAXjzi4wlpbYmlfuapo2zBSVqLKwbEc2334COVzc2
	8TJLegAYINrJBjcwuO13OYiZvJiEXedVV+vYmddbz/YDmupDiV/Z2bnBPubCmv5u7zDywGfyGeY
	=
X-Gm-Gg: ASbGncvubkp1/CcSPnk69fVOuuP4c9khO0L2QjjuHknuTZhtIe76CqgPyHKS9i5XOkQ
	JiZVof5pyci4aCj22TmP74UhTypQhLj8UFe3nwpLbXqqTDCgwZW1Ln8FtETt8tgwhhV9DzxTpHP
	BAeJIUVJoec9WxH27FkzVZjr+/HpY3mh8tOLAaOwFbcLgrO0F8lLo8nJoUvPisCLtZhZ3jfOKHr
	9W/v0xoA6OLI7ID7wUDxxftEm0vR4KzDlklsHN2xtijC0gqMyCF0zPCK4EcwBrs1l0p7JOyJq/h
	UVld6kQGfDuLZM2JhrHAb+rmHlh1ft+lJmLa2rtogyUywefz5sjBffQdCpcYsQ4/+XjpbLfjHZ7
	s5qEoDZw3
X-Google-Smtp-Source: AGHT+IEKEY3NCWVnDEic549TeleorztKPGTcRlVaKRbDXW5Hp3aXJ83+5xxIOJeWKtaUPt08r9B2Vw==
X-Received: by 2002:a17:902:ce0f:b0:223:397e:a55b with SMTP id d9443c01a7336-22780c7a6bemr82093895ad.4.1742846036672;
        Mon, 24 Mar 2025 12:53:56 -0700 (PDT)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com. [209.85.216.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf59cd49sm12669175a91.22.2025.03.24.12.53.56
        for <virtualization@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:53:56 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso7966156a91.1
        for <virtualization@lists.linux.dev>; Mon, 24 Mar 2025 12:53:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuPQilTtIghkeoymw37vl+k065lByIUb32rsIsZnUsJq8A9T+TVB5lQdUUznx7hxwIrJAqDPieV2S6vLSZsw==@lists.linux.dev
X-Received: by 2002:a17:90b:3c43:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-3030fe856edmr26859916a91.12.1742846035557; Mon, 24 Mar 2025
 12:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250324144300.905535-1-maxbr@linux.ibm.com>
In-Reply-To: <20250324144300.905535-1-maxbr@linux.ibm.com>
From: Daniel Verkamp <dverkamp@chromium.org>
Date: Mon, 24 Mar 2025 12:53:29 -0700
X-Gmail-Original-Message-ID: <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr8NkPVuPg1PsgQ4_ODpRqhP97dQpSu7kwfiH-2QqcmVeUNUWXdtuP21V8
Message-ID: <CABVzXAn1iNHP_8h-sj1mTJDuu9dxOBhwi+nbhhr9d27NTo-6wg@mail.gmail.com>
Subject: Re: [PATCH] virtio_console: fix order of fields cols and rows
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	mst@redhat.com, pasic@linux.ibm.com, amit@kernel.org, schnelle@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:43=E2=80=AFAM Maximilian Immanuel Brandtner
<maxbr@linux.ibm.com> wrote:
>
> According to section 5.3.6.2 (Multiport Device Operation) of the virtio
> spec(version 1.2) a control buffer with the event VIRTIO_CONSOLE_RESIZE
> is followed by a virtio_console_resize struct containing cols then rows.
> The kernel implements this the wrong way around (rows then cols) resultin=
g
> in the two values being swapped.
>
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> ---
>  drivers/char/virtio_console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.=
c
> index 21de774996ad..38af3029da39 100644
> --- a/drivers/char/virtio_console.c
> +++ b/drivers/char/virtio_console.c
> @@ -1579,8 +1579,8 @@ static void handle_control_message(struct virtio_de=
vice *vdev,
>                 break;
>         case VIRTIO_CONSOLE_RESIZE: {
>                 struct {
> -                       __virtio16 rows;
>                         __virtio16 cols;
> +                       __virtio16 rows;
>                 } size;

The order of the fields after the patch matches the spec, so from that
perspective, looks fine:
Reviewed-by: Daniel Verkamp <dverkamp@chromium.org>

Since the driver code has been using the wrong order since support for
this message was added in 2010, but there is no support for sending
this message in the current qemu device implementation, I wondered
what device code was used to test this when it was originally added. I
dug up what I assume is the corresponding qemu device change from the
same era, which sends the VIRTIO_CONSOLE_RESIZE message using the
rows, cols order that matches the kernel driver (and differs from the
spec):

https://lore.kernel.org/qemu-devel/1273092505-22783-1-git-send-email-amit.s=
hah@redhat.com/
("[Qemu-devel] [PATCH] virtio-serial: Send per-console port resize
notifications to guest", May 6, 2010)

However, I don't believe that patch ever made it into an actual qemu
release, so it's probably not a compatibility concern. (If there are
any other device implementations that use the kernel driver order
rather than the spec order, then maybe this would need more
consideration, but I don't personally know of any.)

Thanks,
-- Daniel
