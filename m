Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957811;
	b=2iV4rYXHxHbxVcBm224UMSLXVzHb+uA0wO3TIW9Dbb98y19Fjt1LTsZF1Fyjzb/H9lVu
	 uZZ/w06HO0c4UMgita3CDjOjoanxypjDRxbwgdPpjM7ZMuar8p5GVbhL/UXkHSqNibzkQ
	 XZ1YmQp2GmtbkCzp6FjrvHDYktbmSWHiMytPLlijWJQWclPwy544qz0mepb/JyNY+v32P
	 y75P0Wen9k0fnEOL09T+8BlNBiq9oojGbPbF5UYJ9LmXhRi4s8hEg4v3uXH3Ra6mVLRCM
	 7W89Sy2CyR9bK4BnC8cOsAsUW1KUVVn37xnalkHH7AxjaToyQ+uSFj9LPO0NEE0Bp8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957811;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=S9LGaEXB1E1wvy0Af1RCtMcyHpRCTnV7LkNTlfEWfg4=;
	b=HIsDPW+MDQnUfWd92+hpQgz3kF4LuqZFa7i0gofay6RynenvIC7DnCrATWbOyDfK97Vi
	 QXCU+7tIErWxkv4oA8VEu9PBvtaKIgu65cuj4crz/JQZNHqfrNMaMyu7S3M5+6Z1OkIZH
	 3fqUKs0LPSEcYi8R+T272trDHCLAFmbfZTdxx0cg0H6DkKmnyGhu9eaNF1FHVjGsKc/rz
	 4g9iSB/VgLW9GglNocjCS2fwKG7sgcjHCxDzil7utfWPh1NUHxEWzUO1T3BNd/AhzpK2H
	 /OaFhVlQgxFU5zITfuO9O6GlQNrg3W0r0fcKub8Ppz7l4eNxfWCM0roDC6WcKrH/8hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BzEk1R73;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5216077CC5
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 09:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E5216077CC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=BzEk1R73
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b596569640so642464a12.1
        for <virtualization@lists.linux.dev>; Fri, 06 Nov 2026 01:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793957809; x=1794562609; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9LGaEXB1E1wvy0Af1RCtMcyHpRCTnV7LkNTlfEWfg4=;
        b=BzEk1R73R/CIejCkumdeOpkHpySWN6O5faYky5jATvoe5iK6H/P8b8aOrvZQiqgBRh
         hljH0pCDvJ0BDBb0G+tp/2G5Ak9b5Ipd1iX3wo3hStwocvZYfpL/WFumW59t3WxxRlrx
         NJ/N7rL4eog8CDG9jnX8IlCvcv9Uflowo4mG0qUnYfCBFixlbQS+njcEy7JQCAq1Hj30
         VyvP+ud7RSlXeahlLavowO1w6NUPs14TBZw902U7jp+xzKMei0/xWv4jmYqWsIIquIAe
         kiUdgSNTxVkRo4tJpYpGlli8UQV3MCu/o4kGU26dhCFOsdbxzOsrtx/m2CRgQMjJRUBH
         eSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793957809; x=1794562609;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9LGaEXB1E1wvy0Af1RCtMcyHpRCTnV7LkNTlfEWfg4=;
        b=2udczaKotEY5nPc+0UbXzwE5/witbtfQXIHvRXn5YeWTJNb9+n5PCwBIdyuF/G0ufL
         LvsTBCPSAwJZOo/tcUEKJpXP+0ucoqK7IpyGjQgFbFjx9o7CoCL5yTXkkqJ80USGlJAu
         KtDtCEbrNRRkpf/nRr3fNxN+WLhxiIj7JTi3yQ/8fjDHuXATejq4g7yG2LPa2Vck9eHU
         Iqnv7DZwzBaJbed97R4hPFkgGGZnN257cdNr4Nui6NiUDiFYXnr6FixFq64y/nmKlD9F
         7cKyfObUITbMcSSnL0vDKIEz3fqcWjUZtVQu8EaZ06y5N0/i+2Oij+qao6vfQfDLq3d6
         6Psw==
X-Forwarded-Encrypted: i=1; AKwUvByJvd0P9vFg71xLEOfUzLyttKRCpnHjQkWnAN4Ximkp0pran3d0h/TeDlO3srKpr+Ck3EUwvrrHHyvhiFj4FA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sNkpVAHypKgYiOsQKmI6xti96vmIsGiMfhVgNqUPzZu2Wziwx
	AjTAssUpurDeioDtLgaeKvoQlmsR8NdvwmAPXtlAeuEwz0E4MIxCuKAtYNUq9FzXs8Q=
X-Gm-Gg: AYBFou2Z0mSo8hnbgaR9e6D8PJxOgTJAfJyVAfwHpCIPAX7EVWs9Ovqj5nmUDLuzn47
	VvvhQXcaPghkW1GipJygTjfEsGThy1tKhzxzitZ7SXanNfSZtj4lKutdi4e8D1R/YfuKdTEi8Id
	vwAmo2sUNwCrKfjmKpWYgkxMBo5Qf00A1EyPL0EyBFPloX9H1DmzpDrNcdUOkvz/Ydf5Z0DXsLS
	VIvppNCX91E/U753wlB0CTOQiS/8WZkmfNX1ZcQTTROOj3xl+t0tqI9qQKz4RGeViQzz8r4oB5b
	B6vmxpwk8b9hAtl6y2pTh+cihQR2yCkLkYtN8DbeOY0oi6zaGBRxE2IO6mn9z8Dwo+v/JSGgB77
	7ndaJT5ORvXuzjW9lbA7MyYJ2GkXd3vY3tq9iPoz1hYwM0w+z5A+xANVhwQK/vVv2QHz9Kgk9Ku
	lPf5/ypck7+Knub1mF3MP/7LhCIKvNOtA4Wi3I0zv+aeHkHFGNk9WHQkGGS/2fYMQn2E029r9lv
	ZjTsnQ+9zN3yWtislWe830leSKW4/UapXaogIf5PKE6UW8QVLeyUIk3cO0WNy/ZNoWOPLk9gbo/
	cJT9RMRJ9ymZ8FMUGsSjLpBYMZJ6baq/jztBGVULbC9xNH+4HzMM3YRdvLLhPst9nIlRmakzGiv
	bj25ArAyuswqzbA==
X-Received: by 2002:a05:6402:5d5:b0:6b1:c521:ebda with SMTP id 4fb4d7f45d1cf-6b5977f69bamr1395049a12.14.1793957808889;
        Fri, 06 Nov 2026 01:36:48 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b65d6b3a1csm523809a12.2.2026.11.06.01.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:36:48 -0800 (PST)
Date: Fri, 6 Nov 2026 10:36:46 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bobby Eshleman <bobbyeshleman@meta.com>
Cc: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, Stefano
 Garzarella <sgarzare@redhat.com>, <virtualization@lists.linux.dev>, Bobby
 Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH RFC iproute2-next 2/2] ip: add "ip vsock" to move the
 guest vsock device to a netns
Message-ID: <20261106103646.41a0f13a@stephen-xps.local>
In-Reply-To: <20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
References: <20261105-vsock-guest-ns-v1-0-b1c11b3b69c7@meta.com>
	<20261105-vsock-guest-ns-v1-2-b1c11b3b69c7@meta.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Nov 2026 11:30:36 -0800
Bobby Eshleman <bobbyeshleman@meta.com> wrote:

> The guest's vsock device is not a netdev, so rtnetlink cannot move it
> between network namespaces. Add an "ip vsock" object that goes through
> the "vsock" generic netlink family instead:
> 
>   ip vsock set netns { PID | NETNSNAME | NETNSFILE }
>   ip vsock show
> 
> "set" issues VSOCK_CMD_DEV_NETNS_SET from inside the target namespace,
> since the kernel moves the device to the namespace the request was sent
> from. "show" issues VSOCK_CMD_DEV_NETNS_GET and prints where the device
> is, relative to the current namespace.
> 
> Link: https://lore.kernel.org/all/20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com/
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---

Semi-automated review using review-prompts for iproute2


On Thu, 5 Nov 2026 11:30:36 -0800, Bobby Eshleman wrote:

Thanks, this is mostly in good shape. A few things to fix before it
goes beyond RFC.

> +#include <linux/vsock_netlink.h>

This depends on a uapi header (and kernel series) that is not yet
merged. iproute2-next can only take this once the kernel side is in
net-next; the header update should then come from the normal uapi
sync rather than a hand-added copy in patch 1/2.

> +static int vsock_talk(__u8 cmd, struct nlmsghdr **answer)
> +{
> +	GENL_REQUEST(req, 128, 0, 0, VSOCK_FAMILY_VERSION, cmd, NLM_F_REQUEST);
> +	struct rtnl_handle grth = { .fd = -1 };
> +	int family = -1;
> +	int ret;
> +
> +	if (genl_init_handle(&grth, VSOCK_FAMILY_NAME, &family)) {
> +		fprintf(stderr,
> +			"Cannot resolve the \"%s\" netlink family, the kernel may not support moving the vsock device.\n",
> +			VSOCK_FAMILY_NAME);
> +		return -1;
> +	}

genl_init_handle() leaves the socket open when genl_resolve_family()
fails, so this leaks grth.fd. Harmless today since ip exits, but not
under "ip -batch". Add rtnl_close(&grth) on this path.

Also genl_resolve_family() already prints "Error talking to the kernel"
on failure, so the user gets two messages. Not a big deal, just be aware.

> +static void vsock_print_netnsid(int id)
> +{
> +	char *name;
> +
> +	if (is_json_context()) {
> +		print_int(PRINT_JSON, "netnsid", NULL, id);
> +		return;
> +	}

This copies the IFLA_LINK_NETNSID pattern from ipaddress.c, which is
fine for consistency, but note that JSON users never get the netns
name and get -1 for "unknown". Consider also emitting
print_string(PRINT_JSON, "netns", NULL, name) when a name exists.

> +int do_ipvsock(int argc, char **argv)
> +{
> +	if (argc < 1)
> +		return vsock_dev_netns_show();
> +
> +	if (matches(*argv, "show") == 0 ||
> +	    matches(*argv, "list") == 0) {
...
> +	if (matches(*argv, "set") == 0)
...
> +	if (matches(*argv, "help") == 0)
> +		usage();

and in vsock_set():

> +		} else if (matches(*argv, "help") == 0) {

New code must use strcmp(), not matches(). Abbreviation matching has
caused repeated breakage when keywords are added later (e.g. "s" here
already matches both "show" and "set"; order decides which wins).
Please convert all of these to strcmp().

> +	ret = rtnl_talk(&grth, &req.n, answer);
> +	rtnl_close(&grth);
> +
> +	return ret < 0 ? -2 : 0;

The -2 propagates out as the exit status of ip (254). Other ip
subcommands return -1/1 on failure; either is fine but please be
consistent with vsock_dev_netns_set() which returns -1 for its own
errors and -2 for a kernel error.

> +		"Usage:	ip vsock set netns { PID | NETNSNAME | NETNSFILE }\n"
> +		"	ip vsock show\n");

Literal tabs in the usage string; the rest of ip uses spaces for
alignment here ("Usage: ip vsock ...\n       ip vsock show\n").
Also "ip vsock help" should be listed.

> +static int vsock_dev_netns_set(const char *netns)
> +{
...
> +	if (setns(netns_fd, CLONE_NEWNET) < 0) {

Design note, more for the kernel side than this patch: because
VSOCK_CMD_DEV_NETNS_SET has no target attribute, userspace has to do a
setns() dance, and "ip -n foo vsock set netns bar" ends up depending on
which namespace the genl socket was opened in. rtnetlink and devlink
both take an explicit NETNS_FD / NETNS_PID / NETNS_ID attribute for
this; doing the same for vsock would make the tool trivial and avoid
needing setns() (and the privileges to enter the target ns) at all.
Since this is RFC on both sides it seems worth reconsidering now.

If the kernel API stays as is, the setns/restore logic looks correct.

> +ip vsock set netns 1
> +.RS 4
> +Move the device back to the initial network namespace, undoing the assignment.

That only holds if ip is run in the initial pid namespace; "1" is a
PID, not "the initial netns". Maybe say so, or use /proc/1/ns/net.

Minor: the man page says "Nothing follows vsock when the device is in
the current namespace" -- worth also showing an example of the
"netnsid unknown" output so users know what it means.
