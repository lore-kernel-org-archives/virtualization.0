Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605740;
	b=Yi0WiruiJXeeaum7sJV0Jbhe62MYNGUGiWj+4TTABIalXN11/lNngRrqWcFb3sqP4Gqz
	 z5WYYJHt+5WDD3ZVMeWJK/3m2eCdR5VqafA/+RouN5IxrE8UO9AO0v5igLa0aE+s9DdfL
	 IRReE1Xl4By878YZ2r03r2xT7IIpWOPcSyjr4XgJA4nLTUMltHaWOYglNFqQqira5KEnL
	 IvnSgBehy7NAZwjoqTuFrHOr62/wg9Tagn2NpobT8IQgUrB/pdAps3Gs86a/dX2Uy9B8X
	 tMGuFlwFPtb/9ddy3bIvgqfOWKhWJemRshcvyxQ94BB97PdolCRqk4OwarqegV/R6rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605740;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Date:From:To:
	 CC:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Originating-IP:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=4iOYl7h/u5X/1BsQ9LaeXNUXC89a9eBu1n0c2YTCfu4=;
	b=gJy4pqSCJhJ/8furMo7sU9YrUvOq0A6LyTWAmyVIqNOXSdEqwoLuCctLqhHJlhpr0wSm
	 HR9jYExCRyUycm/qQ6GKH+eQoYWPkSHP0Nwf9VatdctcmpFJJz08MaGONAwFdlPlPGMjN
	 7FproLXfPvBXa71iO4Bm4JAhXXi6Itf4bJc1dJDu7PnFjNMjFHKqXatYfQbqulqtMIg3S
	 7IU39ATz2FaEu45ZyLdxYdc0p0JaIV4/3Mh2lr6eZ/eWehVIFzQYgDOojejg8jZM6x6eF
	 ZSoEw7y4hSKX1saR3XAxPWTqS4ZeQEE2gnSuLrw/koulTqevp7hzwYRAFZA0QBgG6mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=meta.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=F8CFVQ0F;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65C606A337
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 21:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A65C606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=F8CFVQ0F
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADLT1cg2585617;
	Fri, 13 Nov 2026 13:35:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps82601-s2048-2026-q3; bh=4iOYl7h/u5X
	/1BsQ9LaeXNUXC89a9eBu1n0c2YTCfu4=; b=F8CFVQ0Fw9/v03E8EGjly7S8Vk2
	n0+khaT3g9ocy0Pj5e1cls1ce9nvvlQkSsyqMjVu95MpXqaR+INDoR58zirga3IQ
	cMtbFo8iudqnUkwuf4yn1InSC9DlDtPrJadjHONwwadVqXdFlHN/PGM0wTtR0G+I
	68gC0klBYgnZZj9IZ/jBfx/b8hncEsv7gCmS7mNBO18/9wDL1PTJ7PM3yTWxf7c+
	sJx3eudRdaTwNMcI5aVdMzaL/QVDYOpa1pt4n8fCVxDGshnDfmaE+5q2dStX3Zps
	gI+uaMtZh5iUJoIYwsFiQlB3nOUKDd9l8LGk61DDdotOHcNF7Lr8oJ3bQOw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hwjg5ruhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Nov 2026 13:35:35 -0800 (PST)
Received: from localhost (2620:10d:c0a8:fe::f072) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 13 Nov
 2026 21:35:34 +0000
Date: Fri, 13 Nov 2026 13:35:33 -0800
From: Bobby Eshleman <bobbyeshleman@meta.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>,
        Stefano
 Garzarella <sgarzare@redhat.com>,
        <virtualization@lists.linux.dev>
Subject: Re: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the
 guest vsock device to a netns
Message-ID: <aveCpf9XDQMCV0fK@devvm29614.prn0.facebook.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
 <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
 <20261106103646.41a0f13a@stephen-xps.local>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261106103646.41a0f13a@stephen-xps.local>
X-Proofpoint-ORIG-GUID: JKUT2pGgrnFahTRmpNO8QHCVZIxj_PD6
X-Proofpoint-GUID: JKUT2pGgrnFahTRmpNO8QHCVZIxj_PD6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA4NiBTYWx0ZWRfXzy7MxeUUzERD
 NWG+geB4ff7yaYbafDTzsA83HwRgg74tXU3Wb20Q3rrqmjb5gxA7alLnpoS5QYjnmPpMQJHN8Z4
 9KusjkfEu1Wxh1yHInte9szAimAI4ow=
X-Authority-Analysis: v=2.4 cv=Mcb5KJ/f c=1 sm=1 tr=0 ts=6af782a8 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=VEq9NWtHcDJz48dA:21 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=N7c5Zlm_GsJ_Jf1E2xsA:9 a=CjuIK1q_8ugA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NiBTYWx0ZWRfX8mS0i7qB91Cp
 n78gokfkDjyc24R6hTKLOle2iz6Z/RYpPzAYxUNG17c40LBJaOsUf1RqiLElivAOGhMABCj+cnT
 Wz7Fj5+VLO/LLAYarvw+MT8aaLOtlJAVb1sgXPEF7pr1V/fXJ1lzNIZg6YoaDxHwaiuOV7CqyU4
 pSLqHMsehhEQVI/YQ5Np8SCovnVBqOFs+66YCNojafGl9ZIwwl7c85Ca5fYQK3q063hF+TzLpzE
 NXJwAdcwNcbW1BU1yf4dKvZmmCGkPTF0w80STh6jxf3g0tnszvl0dsH8dwU/wn2gNy8XUKmhEi4
 6npN3jfdleeKuppC4OclaKi7Fxt87QZ5emMI/IIeFMyb+cKJENpBeTQYLiBtI4T5AL4JaADQ18u
 iSaLMrbvlHqHKODLJgNpySahfE25BVqhUDjp1nxSA3ODkEbfbMn01J/obrKP9UpEdB4Eegk9VPG
 MxCDhHJT2G3KgtI/2kw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_06,2026-11-11_03,2025-10-01_01

On Fri, Nov 06, 2026 at 10:36:46AM +0100, Stephen Hemminger wrote:
> On Thu, 5 Nov 2026 11:30:36 -0800
> Bobby Eshleman <bobbyeshleman@meta.com> wrote:
> 
> > The guest's vsock device is not a netdev, so rtnetlink cannot move it
> > between network namespaces. Add an "ip vsock" object that goes through
> > the "vsock" generic netlink family instead:
> > 
> >   ip vsock set netns { PID | NETNSNAME | NETNSFILE }
> >   ip vsock show
> > 
> > "set" issues VSOCK_CMD_DEV_NETNS_SET from inside the target namespace,
> > since the kernel moves the device to the namespace the request was sent
> > from. "show" issues VSOCK_CMD_DEV_NETNS_GET and prints where the device
> > is, relative to the current namespace.
> > 
> > Link: https://lore.kernel.org/all/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com/
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> 
> Semi-automated review using review-prompts for iproute2
> 
> 
> On Thu, 5 Nov 2026 11:30:36 -0800, Bobby Eshleman wrote:
> 
> Thanks, this is mostly in good shape. A few things to fix before it
> goes beyond RFC.
> 
> > +#include <linux/vsock_netlink.h>
> 
> This depends on a uapi header (and kernel series) that is not yet
> merged. iproute2-next can only take this once the kernel side is in
> net-next; the header update should then come from the normal uapi
> sync rather than a hand-added copy in patch 1/2.
> 
> > +static int vsock_talk(__u8 cmd, struct nlmsghdr **answer)
> > +{
> > +	GENL_REQUEST(req, 128, 0, 0, VSOCK_FAMILY_VERSION, cmd, NLM_F_REQUEST);
> > +	struct rtnl_handle grth = { .fd = -1 };
> > +	int family = -1;
> > +	int ret;
> > +
> > +	if (genl_init_handle(&grth, VSOCK_FAMILY_NAME, &family)) {
> > +		fprintf(stderr,
> > +			"Cannot resolve the \"%s\" netlink family, the kernel may not support moving the vsock device.\n",
> > +			VSOCK_FAMILY_NAME);
> > +		return -1;
> > +	}
> 
> genl_init_handle() leaves the socket open when genl_resolve_family()
> fails, so this leaks grth.fd. Harmless today since ip exits, but not
> under "ip -batch". Add rtnl_close(&grth) on this path.
> 
> Also genl_resolve_family() already prints "Error talking to the kernel"
> on failure, so the user gets two messages. Not a big deal, just be aware.
> 
> > +static void vsock_print_netnsid(int id)
> > +{
> > +	char *name;
> > +
> > +	if (is_json_context()) {
> > +		print_int(PRINT_JSON, "netnsid", NULL, id);
> > +		return;
> > +	}
> 
> This copies the IFLA_LINK_NETNSID pattern from ipaddress.c, which is
> fine for consistency, but note that JSON users never get the netns
> name and get -1 for "unknown". Consider also emitting
> print_string(PRINT_JSON, "netns", NULL, name) when a name exists.
> 
> > +int do_ipvsock(int argc, char **argv)
> > +{
> > +	if (argc < 1)
> > +		return vsock_dev_netns_show();
> > +
> > +	if (matches(*argv, "show") == 0 ||
> > +	    matches(*argv, "list") == 0) {
> ...
> > +	if (matches(*argv, "set") == 0)
> ...
> > +	if (matches(*argv, "help") == 0)
> > +		usage();
> 
> and in vsock_set():
> 
> > +		} else if (matches(*argv, "help") == 0) {
> 
> New code must use strcmp(), not matches(). Abbreviation matching has
> caused repeated breakage when keywords are added later (e.g. "s" here
> already matches both "show" and "set"; order decides which wins).
> Please convert all of these to strcmp().
> 
> > +	ret = rtnl_talk(&grth, &req.n, answer);
> > +	rtnl_close(&grth);
> > +
> > +	return ret < 0 ? -2 : 0;
> 
> The -2 propagates out as the exit status of ip (254). Other ip
> subcommands return -1/1 on failure; either is fine but please be
> consistent with vsock_dev_netns_set() which returns -1 for its own
> errors and -2 for a kernel error.
> 
> > +		"Usage:	ip vsock set netns { PID | NETNSNAME | NETNSFILE }\n"
> > +		"	ip vsock show\n");
> 
> Literal tabs in the usage string; the rest of ip uses spaces for
> alignment here ("Usage: ip vsock ...\n       ip vsock show\n").
> Also "ip vsock help" should be listed.
> 
> > +static int vsock_dev_netns_set(const char *netns)
> > +{
> ...
> > +	if (setns(netns_fd, CLONE_NEWNET) < 0) {
> 
> Design note, more for the kernel side than this patch: because
> VSOCK_CMD_DEV_NETNS_SET has no target attribute, userspace has to do a
> setns() dance, and "ip -n foo vsock set netns bar" ends up depending on
> which namespace the genl socket was opened in. rtnetlink and devlink
> both take an explicit NETNS_FD / NETNS_PID / NETNS_ID attribute for
> this; doing the same for vsock would make the tool trivial and avoid
> needing setns() (and the privileges to enter the target ns) at all.
> Since this is RFC on both sides it seems worth reconsidering now.

This does make sense, we'll use this approach in the kernel.

> 
> If the kernel API stays as is, the setns/restore logic looks correct.
> 
> > +ip vsock set netns 1
> > +.RS 4
> > +Move the device back to the initial network namespace, undoing the assignment.
> 
> That only holds if ip is run in the initial pid namespace; "1" is a
> PID, not "the initial netns". Maybe say so, or use /proc/1/ns/net.
> 
> Minor: the man page says "Nothing follows vsock when the device is in
> the current namespace" -- worth also showing an example of the
> "netnsid unknown" output so users know what it means.

Will address other feedback too.

Best,
Bobby
