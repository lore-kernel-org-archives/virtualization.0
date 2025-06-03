Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01453136E37
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748920762; cv=none; b=er4L5plK7FDVxMVMorqP9rz9oAP3Vr9t9AWotiWcmSK2k5hT1R8TEGfSwS5UoJOXlemSY4oRnlm7uMBJm4yE1HrbNX+yVQu4Ly8GGV4uEhjZW543gQNy0Gw/3VzhRqSEHoFDRvp84bMF13OKTARP6Zixwsoc4eFnAv/8Djs6OW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748920762; c=relaxed/simple;
	bh=ulahXhuT8yDizo0bw9N/2oF8mAlXjmDARNszSAnWgEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p632fJKSKzo0/HjCx41AtfrgMf/jFtsKcHWCEFqeeLUyAK8+VOSVFELtsI+ePGYuDLf+wYtqu+j84jr6m4PDet7Wasv50ExAG2H3GRDSSadpWPYrkg36r0QKy4yfz6iBHof/GDEdEiYoMuMMN68v6RucLbN5tdiVuw9IM/MEfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9kmRvo/; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9kmRvo/"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66EE1614C9
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 03:19:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aKQZ2ZT1yf-k for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Jun 2025 03:19:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9DBD860DA0
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DBD860DA0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c9kmRvo/
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DBD860DA0
	for <virtualization@lists.linux-foundation.org>; Tue,  3 Jun 2025 03:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748920757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aLUswlGrIATyOOlI6fhYu4jJYFEad2pBjyge/hX+nFY=;
	b=c9kmRvo/bTbgE2fbYbh7Z4pyeARezSCdE3nHcglQD0Q7/eZtFtpFh1wDYY3718cgouArSd
	pa6wuilqGcz93kvHgfDmo5S+eXIixRpNqFKVVx3fBMoYFFwJ4fAwjXme5/rN+2FVLe18IZ
	arzkNu+P08srjPMg+BT1iDVrh5tjmsI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-WvmbhPlvNMSS6bKbzmHdnA-1; Mon, 02 Jun 2025 23:19:16 -0400
X-MC-Unique: WvmbhPlvNMSS6bKbzmHdnA-1
X-Mimecast-MFC-AGG-ID: WvmbhPlvNMSS6bKbzmHdnA_1748920755
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235842baba4so16340115ad.3
        for <virtualization@lists.linux-foundation.org>; Mon, 02 Jun 2025 20:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748920755; x=1749525555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLUswlGrIATyOOlI6fhYu4jJYFEad2pBjyge/hX+nFY=;
        b=gqk+8n5yDvQlkQN+6P9OFK98mHEUpGPa6vfIgHpPAMoz7pkRTzQuEG5nythgi+9osX
         oIicIDhUxUaUcNj5LpGaYKjKu8m67f3gbAI84PHP9Wp1a5ugn1/wEgmHndPOxSn5G2I6
         L608yzeFenkY0TZregoVQzF+dswyA9/CUF52xK+hbOIHpGbSoeGI4QAMJAquEyC+Yln8
         wRlUAud8AQ2GpbvSlxKLkpd+JpBDED8X5okhLKn2NPmvbEA3yx6xCAS+75mjySCRS+kk
         tVGr7U/h/hH1jUPil2R7yzElggxJjsbXY5bUYgNTaMNUWLbJ88XS7y82p6x4XhaOzKKE
         O0MA==
X-Forwarded-Encrypted: i=1; AJvYcCW3lMkhh2PD9ur/4O8QSegAK9R2MvhSeD0XlZ8RdR9gaRJJj7Y+6f3raW5HPSqK2S84M7HTo94rejb0hEQClg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxNIM1UUBtSlOmbGBtRpUA4jGGY3wGJPzNfxU2Xz76FYF1+F5U9
	6OhvDpN947EzRBM0ZwZwVHC8EVUtKQGSpnNfzbBTiJUVJ/3jUb+CWpc91L6qjUW1ZO3HxQs5Fq/
	4Zg1jzgCvXf15+q+ff0TjB8S40aW6wHxIZGRi7vCjJLalBpqv+Njm7wj7QPCRnBO24XuHHnQ+Gx
	+pYCTgKTzBCXV1DkJI3uTCHpnRqGLM8h7NVqlaKXz9D7nZwcbrmA4H9bd8PA==
X-Gm-Gg: ASbGncsfP7CnDrrYrO2+40G3KpMttnv6y76q5I9zX9MOwFy2VqW+k2MvuZjgZq3jTWD
	Jjf6YNxEmvxHdPpG7SFrXTNdzdYiBUMN7gFoO478F6/ZNrg29o7Ts1kJeM858TV1d7lT9NDKd6e
	D9zD0b
X-Received: by 2002:a17:902:e849:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-23529904f21mr247668495ad.37.1748920755179;
        Mon, 02 Jun 2025 20:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHywPCLM/Qh3jSdbKsF9dOuO472rVd+vIBVeTePaa/6GUJRTTw4v5rkd8bePaost/OoMXAMwCrz5QAOrqb7r5E=
X-Received: by 2002:a17:902:e849:b0:234:8a4a:ada5 with SMTP id
 d9443c01a7336-23529904f21mr247667985ad.37.1748920754675; Mon, 02 Jun 2025
 20:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250530-rss-v12-0-95d8b348de91@daynix.com> <20250530-rss-v12-1-95d8b348de91@daynix.com>
In-Reply-To: <20250530-rss-v12-1-95d8b348de91@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 3 Jun 2025 11:19:03 +0800
X-Gm-Features: AX0GCFv2w2DYNXanInKBc5HQRF8lqBk-gAKp63FMQ8nnSSAfo4iUv1CXTbXlSAw
Message-ID: <CACGkMEufffSj1GQMqwf598__-JgNtXRpyvsLtjSbr3angLmJXg@mail.gmail.com>
Subject: Re: [PATCH net-next v12 01/10] virtio_net: Add functions for hashing
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, 
	Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BnpBt8I48Zx3kuUQ8cRvlnPgpDIqEGxkCGmkE4rcJ1Y_1748920755
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> They are useful to implement VIRTIO_NET_F_RSS and
> VIRTIO_NET_F_HASH_REPORT.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Lei Yang <leiyang@redhat.com>
> ---
>  include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 188 insertions(+)
>
> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 02a9f4dc594d..426f33b4b824 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -9,6 +9,194 @@
>  #include <uapi/linux/tcp.h>
>  #include <uapi/linux/virtio_net.h>
>
> +struct virtio_net_hash {
> +       u32 value;
> +       u16 report;
> +};
> +
> +struct virtio_net_toeplitz_state {
> +       u32 hash;
> +       const u32 *key;
> +};
> +
> +#define VIRTIO_NET_SUPPORTED_HASH_TYPES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv4 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_IPv6 | =
\
> +                                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6 |=
 \
> +                                        VIRTIO_NET_RSS_HASH_TYPE_UDPv6)
> +
> +#define VIRTIO_NET_RSS_MAX_KEY_SIZE 40
> +
> +static inline void virtio_net_toeplitz_convert_key(u32 *input, size_t le=
n)
> +{
> +       while (len >=3D sizeof(*input)) {
> +               *input =3D be32_to_cpu((__force __be32)*input);
> +               input++;
> +               len -=3D sizeof(*input);
> +       }
> +}
> +
> +static inline void virtio_net_toeplitz_calc(struct virtio_net_toeplitz_s=
tate *state,
> +                                           const __be32 *input, size_t l=
en)
> +{
> +       while (len >=3D sizeof(*input)) {
> +               for (u32 map =3D be32_to_cpu(*input); map; map &=3D (map =
- 1)) {
> +                       u32 i =3D ffs(map);
> +
> +                       state->hash ^=3D state->key[0] << (32 - i) |
> +                                      (u32)((u64)state->key[1] >> i);
> +               }
> +
> +               state->key++;
> +               input++;
> +               len -=3D sizeof(*input);
> +       }
> +}
> +
> +static inline u8 virtio_net_hash_key_length(u32 types)
> +{
> +       size_t len =3D 0;
> +
> +       if (types & VIRTIO_NET_HASH_REPORT_IPv4)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv4_addrs));
> +
> +       if (types &
> +           (VIRTIO_NET_HASH_REPORT_TCPv4 | VIRTIO_NET_HASH_REPORT_UDPv4)=
)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv4_addrs) +
> +                         sizeof(struct flow_dissector_key_ports));
> +
> +       if (types & VIRTIO_NET_HASH_REPORT_IPv6)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv6_addrs));
> +
> +       if (types &
> +           (VIRTIO_NET_HASH_REPORT_TCPv6 | VIRTIO_NET_HASH_REPORT_UDPv6)=
)
> +               len =3D max(len,
> +                         sizeof(struct flow_dissector_key_ipv6_addrs) +
> +                         sizeof(struct flow_dissector_key_ports));
> +
> +       return len + sizeof(u32);
> +}
> +
> +static inline u32 virtio_net_hash_report(u32 types,
> +                                        const struct flow_keys_basic *ke=
ys)
> +{
> +       switch (keys->basic.n_proto) {
> +       case cpu_to_be16(ETH_P_IP):
> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4))
> +                               return VIRTIO_NET_HASH_REPORT_TCPv4;
> +
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4))
> +                               return VIRTIO_NET_HASH_REPORT_UDPv4;
> +               }
> +
> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4)
> +                       return VIRTIO_NET_HASH_REPORT_IPv4;
> +
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       case cpu_to_be16(ETH_P_IPV6):
> +               if (!(keys->control.flags & FLOW_DIS_IS_FRAGMENT)) {
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_TCP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv6))
> +                               return VIRTIO_NET_HASH_REPORT_TCPv6;
> +
> +                       if (keys->basic.ip_proto =3D=3D IPPROTO_UDP &&
> +                           (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv6))
> +                               return VIRTIO_NET_HASH_REPORT_UDPv6;
> +               }
> +
> +               if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv6)
> +                       return VIRTIO_NET_HASH_REPORT_IPv6;
> +
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +
> +       default:
> +               return VIRTIO_NET_HASH_REPORT_NONE;
> +       }
> +}
> +
> +static inline void virtio_net_hash_rss(const struct sk_buff *skb,
> +                                      u32 types, const u32 *key,
> +                                      struct virtio_net_hash *hash)
> +{
> +       struct virtio_net_toeplitz_state toeplitz_state =3D { .key =3D ke=
y };
> +       struct flow_keys flow;
> +       struct flow_keys_basic flow_basic;
> +       u16 report;
> +
> +       if (!skb_flow_dissect_flow_keys(skb, &flow, 0)) {
> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +               return;
> +       }
> +
> +       flow_basic =3D (struct flow_keys_basic) {
> +               .control =3D flow.control,
> +               .basic =3D flow.basic
> +       };
> +
> +       report =3D virtio_net_hash_report(types, &flow_basic);
> +
> +       switch (report) {
> +       case VIRTIO_NET_HASH_REPORT_IPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_TCPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_UDPv4:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v4addrs,
> +                                        sizeof(flow.addrs.v4addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_IPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_TCPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       case VIRTIO_NET_HASH_REPORT_UDPv6:
> +               virtio_net_toeplitz_calc(&toeplitz_state,
> +                                        (__be32 *)&flow.addrs.v6addrs,
> +                                        sizeof(flow.addrs.v6addrs));
> +               virtio_net_toeplitz_calc(&toeplitz_state, &flow.ports.por=
ts,
> +                                        sizeof(flow.ports.ports));
> +               break;
> +
> +       default:
> +               hash->report =3D VIRTIO_NET_HASH_REPORT_NONE;
> +               return;

So I still think we need a comment here to explain why this is not an
issue if the device can report HASH_XXX_EX. Or we need to add the
support, since this is the code from the driver side, I don't think we
need to worry about the device implementation issues.

For the issue of the number of options, does the spec forbid fallback
to VIRTIO_NET_HASH_REPORT_NONE? If not, we can do that.

Thanks

> +       }
> +
> +       hash->value =3D toeplitz_state.hash;
> +       hash->report =3D report;
> +}
> +
>  static inline bool virtio_net_hdr_match_proto(__be16 protocol, __u8 gso_=
type)
>  {
>         switch (gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
>
> --
> 2.49.0
>

