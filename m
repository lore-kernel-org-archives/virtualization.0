Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A640B0E2
	for <virtualization@lists.linux.dev>; Sat, 17 Oct 2026 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792216816; cv=pass; b=BOYMgqcpQnVwSZUu8SEGWB+l+SVLXNjtool39P82E5arOBWIzDHwE1sXYWAMR/S5OzIfHR8dh/dMeiEJzmUiSLcXX5A1RScy/N2MECNnEiLf6JPuG9qL1NWxKWDzfUxIl0JjgxyV+Z/wmmv4CMO3urHpgFCoYQ5x4wZjJjudXf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792216816; c=relaxed/simple;
	bh=bkvh1i5FG37o5A9ttSAH20Uqm6CK5XS7/r4HenKlm/A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZEdjGPAVFc9HmQCtOHJ0Xq5x+22JRR3ZBbbvOWw5wqYmBY2DvOcMLPhhizHBCrlD7xP/oq7EEoCjWv9baXv7pW4GnUP1dcMvT0u1Gx8fd2D9lC2yuuaUgmMiRhKin/KVHr8IwgiYMcRieBlwbMSKHM84f9dXRTOwG4jk1LMXqJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oMldbcRX; arc=pass smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oMldbcRX"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91bb5795792so24976d6.2
        for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 23:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792216814; cv=none;
        d=google.com; s=arc-20260327;
        b=YWHLqBNksdj4Or1fiGOREcL5yrPTOPeR+i7frT/oYYJiaDlvno9aLwevtLxSTfe90p
         TBa7uq4q0I33BiCbhBLuiFZExdiuwl18w0PeyHwrxbbNxpl449P8tswFUOoj6U9Y4lWZ
         kzPRsuuu52vca8gpXvGpfKGb8QaDF9X88Vmx81JmaQAD6q7KYOEcKG9YSVHo71CQavqA
         FpxbVy9W+A1EKsHtJzC3FwWNYW6Og3hv1ajPRKMcm7je7rvS8ALMJ4PdzBv4LA1AGn47
         3FjWkckalY45YEgc0uOVFjS4EhF1rh6dZ8GCSML6YrE1DhlMUJ2UpYfWiIyHrlQoRD8V
         K+XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=63A2I3xSyjrdJxbGENFhY9IuJPK1dZ8nnNSKYaZbcvw=;
        fh=Z+8/Zl8g/M36YO5NW549+GlAOx/gR1RoYNE6l0mC7QM=;
        b=haoKeKWMPigNte2d+H0zKu8SDMeesIyoqSvdQe1HXAIvFsxOsg/ojBAEB8OcMUsmJ/
         OMQaw65jB7jx64yKyoNOYe0TkuN9+JiPrgZtycC6LNiV59UNONXk95JoxuYkL0+nUnyE
         xc4TWp4DHXrWPH3qzqK+KsfKUy0rTpVyY+ESH33z6TjACqbiSBY8GR83p9HMe2lLdMdx
         wEKPv8/b/HvbSdejpHQlxW9xSsfNjs7rkySJpufb33k7AdXuPjSgrSzZpRz7ugN0dxOs
         dSJn/Gnezw5W8Qj/rgqHmvR+EpCk9n9AL9dFZO5ZQYYVanJdF/vH/NBNl51ro+NSCKPU
         eMoA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792216814; x=1792821614; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=63A2I3xSyjrdJxbGENFhY9IuJPK1dZ8nnNSKYaZbcvw=;
        b=oMldbcRXIh5/yVDSOqu40SUwu+TCk4Dtvc2Wup0SKLr9ZVUMDAlcDJVcPt0veB/E/v
         uIGr8kJVqPcFEO29XtAdNRHKtthxVWNvdiJxYPhk0a0Lh46st3J1Wf7h/ICuk69uZYym
         o5AISOXG1WO7XP/LwchEiWo8nlOEUjGydAZkUCjVCGN+rAjau+G+kE/ADfjPAltBmHl0
         CeQ78FynRA3nktrT3FJ48CsvreIUR5r7OIRm3b7WrIzWimfh9Q0cgAN6xtiI86th6GEf
         iPBloMsEYBpDT63NL0TDtfS4Sav2+SXMqYHfoJb4ch/IzvlSJJMipII60CqREopi5awW
         awaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792216814; x=1792821614;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=63A2I3xSyjrdJxbGENFhY9IuJPK1dZ8nnNSKYaZbcvw=;
        b=G4Op1fbL7646ijgZi3mKjh6XQSnp0uJkWnUkdaK+mIJReDguzjn3vBXDk7SNLh2KBP
         vlk+WZ5/07XGh61RMsa3La8SftGuq6wDPlwPfWRQn/ULSEhjmKZlVTRSRUMqILz1v5J7
         FyZFlTxXZJgykAa/6s3w0VEiOjonBZ4u7EDXfdcTIxd6RiqY/Ul9D8+FWx4GfJqHJ9JN
         KhLrFUqJXn1vn73tdqZJcX48TmsyX5adAlNssaSeGyKMs9jxzycnlocTWS+tlPhfa8zd
         Cyh212ehpGdxq+yp0F8hXsWZesBYiwgBTo0Ue1B5I9aoeeho/BFrSulQvMYEjT0Hh7f8
         Fe/Q==
X-Forwarded-Encrypted: i=1; AKwUvBwF0rr1csu9rAZDZSHz7YcDmIdRtDttU32Yc0xXoC4vXNluB2ndgjTlYMFia4AY+535C3reIWRXPqDjNXa8Tw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJRHFqA4Ig7Ug+qIqNv5br8Z/fx0SSi/JL7bPM6aazxyZlRnaoE
	gg2+FZOy5VWnAOQ8W7CFVEu+1aXnXObRC7aEuMrQZdelt9Tu0kUhZ6V0AAjaJrzP4Hu2FzTXgGe
	9O3t5XJp/xPyra+SdqwCsrv/+VFTZxW0=
X-Gm-Gg: AYBFou3s5v4gwFhMV9suT1VQy56hcc8nax0Wyp6vkpyT01pyT8GT8HU6OoEowgPqTyx
	5Mum60YM3SKubGFIfZqy2kBoNmJZlLInNjUQJk0wPrBE0E1yp2NEaGchg8Jyflgw4/HfylQU2l9
	sO/EcjVqD7W3+EiuRf1y2SPsJ5gEDe+nnQBWloTy3vllDE4woj4YeNTtztUtephBailpM8PHwXj
	8qn5EQyrawkJPa2Xeby3xCXqEQOSw4/jQMTSRSvqdJlsb2E9bJiXR4Eip+IYwh4ajnwEET57RMi
	mdmBSLN8u/RkX89UHEc9izgQxAjAbPpXifgpcR42vIt+TnWujAKnd3iNMqt4rIkx0vWX4emxI4p
	0A42ZZTHwwsVDt4FOd3YJAV5FCaXfLUa8dVm6BY145QN5EqZKN0FTwAjqyRSp4myAX0d3qkD4Ql
	bSWllgSAoUUdozvBlBhmiqeFb1JVhf4m5nkC2u5DjQTsKks+IjUEpj2YZp5URrRFo45z7WPaae2
	ZxManGryrvZM++Fo7W1fduj
X-Received: by 2002:a05:6214:b69:b0:91b:d948:c415 with SMTP id
 6a1803df08f44-91bdf17d414mr36514556d6.44.1792216813780; Fri, 16 Oct 2026
 23:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Megane Hebo <hebomegane@gmail.com>
Date: Sat, 17 Oct 2026 15:00:02 +0900
X-Gm-Features: AclHuK_sX1uqxVMBR6hp7esLRZ_VlhANEBWvmp_0y_cBfyPLvu2acqyIrbaKGgs
Message-ID: <CAJPVW+=XcHDV4aoXt5oAHYh49kX7m5wUxf7TucrcBy+q6MdXFA@mail.gmail.com>
Subject: [RFC PATCH net-next] selftests: net: exercise virtio checksum ingress outcomes
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	mst@redhat.com, virtualization@lists.linux.dev, 
	willemdebruijn.kernel@gmail.com, habte.yibelo@gmail.com, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

The virtio checksum hardening series gives virtio_net_hdr_to_skb()
three outcomes for VIRTIO_NET_HDR_F_NEEDS_CSUM: known-good partial
checksum metadata is retained, uncommon non-GSO metadata is resolved
in software at ingress, and GSO metadata that cannot be resolved safely
is rejected.

Add focused TUN tests for these three outcomes. Keep the packet shape
otherwise identical (IPv4/UDP, no encapsulation), so each test changes
only the metadata needed to select a different branch.

For the software-resolution case, verify the rx_csum_sw ethtool counter
added by the hardening series. A recognized partial checksum must not
increment it. An uncommon non-GSO checksum must increment it once. A
GSO/protocol mismatch must be rejected without incrementing it.

These are contract tests for ingress normalization: packet semantics
must be made consistent before later protocol processing observes the
packet.

This is intended as a follow-up to [PATCH net-next v2 0/7]
"more virtio-net csum hardening".

Signed-off-by: Kiyotaka Tonegawa <hebomegane@gmail.com>
---
Testing:
- applied on current upstream master after Michael's v2 0/7 series
- built tools/testing/selftests/net/tun with the normal YNL dependencies
- runtime against a kernel containing v2: not run

 tools/testing/selftests/net/tun.c | 160 ++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/tools/testing/selftests/net/tun.c
b/tools/testing/selftests/net/tun.c
index afaa81c..8775315 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,7 +8,9 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <linux/ethtool.h>
 #include <linux/if_tun.h>
+#include <linux/sockios.h>
 #include <netinet/tcp.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
@@ -543,6 +545,76 @@ TEST_F(tun, reattach_close_delete)
        EXPECT_EQ(tun_delete(self->ifname), 0);
 }

+static int tun_get_stat(const char *ifname, const char *name, uint64_t *value)
+{
+       struct ethtool_drvinfo drvinfo = { .cmd = ETHTOOL_GDRVINFO };
+       struct ethtool_gstrings *strings = NULL;
+       struct ethtool_stats *stats = NULL;
+       struct ifreq ifr = {};
+       unsigned int i;
+       int fd, ret;
+
+       fd = socket(AF_INET, SOCK_DGRAM, 0);
+       if (fd < 0)
+               return -errno;
+
+       strncpy(ifr.ifr_name, ifname, IFNAMSIZ - 1);
+       ifr.ifr_data = (void *)&drvinfo;
+       if (ioctl(fd, SIOCETHTOOL, &ifr) < 0) {
+               ret = -errno;
+               goto out;
+       }
+
+       if (!drvinfo.n_stats) {
+               ret = -ENOENT;
+               goto out;
+       }
+
+       strings = calloc(1, sizeof(*strings) +
+                        drvinfo.n_stats * ETH_GSTRING_LEN);
+       stats = calloc(1, sizeof(*stats) +
+                      drvinfo.n_stats * sizeof(stats->data[0]));
+       if (!strings || !stats) {
+               ret = -ENOMEM;
+               goto out;
+       }
+
+       strings->cmd = ETHTOOL_GSTRINGS;
+       strings->string_set = ETH_SS_STATS;
+       strings->len = drvinfo.n_stats;
+       ifr.ifr_data = (void *)strings;
+       if (ioctl(fd, SIOCETHTOOL, &ifr) < 0) {
+               ret = -errno;
+               goto out;
+       }
+
+       stats->cmd = ETHTOOL_GSTATS;
+       stats->n_stats = drvinfo.n_stats;
+       ifr.ifr_data = (void *)stats;
+       if (ioctl(fd, SIOCETHTOOL, &ifr) < 0) {
+               ret = -errno;
+               goto out;
+       }
+
+       ret = -ENOENT;
+       for (i = 0; i < drvinfo.n_stats; i++) {
+               const char *stat_name =
+                       (const char *)&strings->data[i * ETH_GSTRING_LEN];
+
+               if (!strncmp(stat_name, name, ETH_GSTRING_LEN)) {
+                       *value = stats->data[i];
+                       ret = 0;
+                       break;
+               }
+       }
+
+out:
+       free(stats);
+       free(strings);
+       close(fd);
+       return ret;
+}
+
 FIXTURE(tun_vnet_gso)
 {
        char ifname[IFNAMSIZ];
@@ -611,6 +683,35 @@ static int build_vlan_tcpv4_gso_packet(uint8_t
*buf, int payload_len)
        return cur - buf;
 }

+static int build_ipv4_udp_partial_packet(uint8_t *buf, int payload_len,
+                                        uint8_t gso_type,
+                                        uint16_t csum_offset)
+{
+       uint8_t *cur = buf + sizeof(struct virtio_net_hdr);
+       struct virtio_net_hdr vh = { 0 };
+
+       cur += build_eth(cur, ETH_P_IP, param_hwaddr_outer_src,
+                        param_hwaddr_outer_dst);
+       cur += build_ipv4_header(cur, IPPROTO_UDP,
+                                sizeof(struct udphdr) + payload_len,
+                                &param_ipaddr4_outer_src,
+                                &param_ipaddr4_outer_dst);
+       cur += build_udp_packet(cur, UDP_SRC_PORT, UDP_DST_PORT,
+                               payload_len, AF_INET, true);
+
+       vh.flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+       vh.hdr_len = ETH_HLEN + sizeof(struct iphdr) + sizeof(struct udphdr);
+       vh.csum_start = ETH_HLEN + sizeof(struct iphdr);
+       vh.csum_offset = csum_offset;
+       vh.gso_type = gso_type;
+       if (gso_type != VIRTIO_NET_HDR_GSO_NONE)
+               vh.gso_size = 64;
+
+       memcpy(buf, &vh, sizeof(vh));
+
+       return cur - buf;
+}
+
 TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum)
 {
        struct virtio_net_hdr vh;
@@ -678,6 +779,65 @@ TEST_F(tun_vnet_gso, vlan_tcpv4_gso_no_csum_64k)
        ASSERT_EQ(ret, len);
 }

+TEST_F(tun_vnet_gso, csum_partial_known_good)
+{
+       uint8_t pkt[512] = { 0 };
+       uint64_t before, after;
+       int len, ret;
+
+       ASSERT_EQ(tun_get_stat(self->ifname, "rx_csum_sw", &before), 0);
+
+       len = build_ipv4_udp_partial_packet(pkt, 128,
+                                           VIRTIO_NET_HDR_GSO_NONE,
+                                           __builtin_offsetof(struct
udphdr, check));
+       ret = write(self->fd, pkt, len);
+       ASSERT_EQ(ret, len);
+
+       ASSERT_EQ(tun_get_stat(self->ifname, "rx_csum_sw", &after), 0);
+       EXPECT_EQ(after, before);
+}
+
+TEST_F(tun_vnet_gso, csum_partial_uncommon_resolved)
+{
+       uint8_t pkt[512] = { 0 };
+       uint64_t before, after;
+       int len, ret;
+
+       ASSERT_EQ(tun_get_stat(self->ifname, "rx_csum_sw", &before), 0);
+
+       len = build_ipv4_udp_partial_packet(pkt, 128,
+                                           VIRTIO_NET_HDR_GSO_NONE,
+                                           __builtin_offsetof(struct
udphdr, source));
+       ret = write(self->fd, pkt, len);
+       ASSERT_EQ(ret, len);
+
+       ASSERT_EQ(tun_get_stat(self->ifname, "rx_csum_sw", &after), 0);
+       EXPECT_EQ(after, before + 1);
+}
+
+TEST_F(tun_vnet_gso, csum_partial_gso_protocol_mismatch_rejected)
+{
+       uint8_t pkt[512] = { 0 };
+       uint64_t before, after;
+       int len, ret;
+
+       ASSERT_EQ(tun_get_stat(self->ifname, "rx_csum_sw", &before), 0);
+
+       /* The checksum field is a valid UDP checksum field, but the
+        * virtio header claims TCPv4 GSO. GSO cannot be resolved as an
+        * arbitrary checksum write, so the ingress contract rejects it.
+        */
+       len = build_ipv4_udp_partial_packet(pkt, 256,
+                                           VIRTIO_NET_HDR_GSO_TCPV4,
+                                           __builtin_offsetof(struct
udphdr, check));
+       ret = write(self->fd, pkt, len);
+       ASSERT_EQ(ret, -1);
+       ASSERT_EQ(errno, EINVAL);
+
+       ASSERT_EQ(tun_get_stat(self->ifname, "rx_csum_sw", &after), 0);
+       EXPECT_EQ(after, before);
+}
+
 FIXTURE(tun_vnet_udptnl)
 {
        char ifname[IFNAMSIZ];
--
2.53.0
