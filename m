Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4F2EEE7C
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209471; cv=none; b=ZUZ+XdVtgZ0dVX7vG29rQqhR7DNLVlni7RvfZazGNhxxs+FIPFz09XVMUcgBRYV+GerWsxTmE9q1sl+wo5bx2oN21KWzLlonUJpCdG0Q6GPD/TAs3dW0vyKVEMMmiDAchMHRkZvWUUt50tSBMJB8FkVgwqfPeep6kqMEFFi+Y+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209471; c=relaxed/simple;
	bh=O1qzz4udeaHiCBtWLNhPqgQhh0np6y2v1Qblzap4ubo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGgT81SQha9c5YOFXRXHmGSkwm4QUIandRsHuJKJkACyjZr9pXMN6Orj9dibUcTfEEHVf7Xa76KpSYfLM3a/vO1K4oq9deCGNbf7dP6SR7rttESCJZB6nVJtf2/YFbl5w2/YNuGvMdByUUVmY+icjM1DWgrCovS0QPdG6LMQ9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EioBmM2D; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EioBmM2D"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfb21so1372756fac.1
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 17:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790209467; x=1790814267; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaNhGxWDXoFu7JrvArFM0xuuSaYLknf+AiNAGeHpOlc=;
        b=EioBmM2DsmoAA/Wy5UL+S9YzG2dZT40UR2CXp6nZjOgDpGsIs/CjLqQXgukBx6WDL6
         B+uUj1w1x6v1TvEtUd2qdp9SIHJ2sk3VzVRQQ2uM/XeVEcb9ii3EnNwqnFEXtGUkB+k8
         T+HHZDxCr0u0B1JnIfDD9ZuDqiJMJdUw5JPSUKHe2eTJdSPow2vmTEFGfmVnjVpvlWrl
         bpk10ddfkhcnVle20/t6GWpokhICvDEwF87QuVI9Bqcmfxu333Oi5EBiOgWM+ORh0G4B
         cB++OE8YOer1SrThvlrPtWBwOjpYQtDz7KaplUI0qEuNVfekGuwmyUudMcHFY9JyfRgT
         s+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209467; x=1790814267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VaNhGxWDXoFu7JrvArFM0xuuSaYLknf+AiNAGeHpOlc=;
        b=trl4a9niBF3NV7q+w1+iKvKsvJEx+HLmHZbzaCUUiQYans0ZDRN9AciAqWPBf2mTsD
         PqdSu4ZJmQxE1lowBw6+Kz1MlaQTuiQFSkA/AV2do8AKYimalUPBYVPUiCgM24c2j56u
         /HfPozy0mWmwRDevITrZMFs8IFLaYeNH4oGaOXt/KC1zIdIcQAwb+uJLuyJQddt2rRfr
         0z3njI/Qf6v1tIfKxy86VL/8GumBaa/M40NmNOjoxvVJ0UOsbYFjC4Q9nluxRIvCba/u
         o6mh1xEADllf6RUKdiRIET3P+va8vpNl45/kbm8b3PS4xeJHmLguW3RzPXOpyvKq8CNf
         YugQ==
X-Forwarded-Encrypted: i=1; AKwUvBx52S+a3ei68QQH6yr8GipY8F+XL0lnYEKiXPVbdFpjIHS7zPY01xgUEOv657bd6+VhtwnC7SOubO3K2y8Zlg==@lists.linux.dev
X-Gm-Message-State: AFuF++mERkuMCw6kyKZlyiit3otC9gfqrirob0rUUlWx5bsxoWatFTLP
	SojQ42CxbPmc3fhC2vNKp9GEKEU8MYS2TXKw4fFMf4eueqzbJZG0my+y
X-Gm-Gg: AYBFou2J+/ztm5PW4K3DIVurgUcwJ4s5zYoRaL14VP+atEwNEEM4NmMQv7Uxf9wLRZF
	hABQTEPFRzXIjz/53LLF/iyx8kHqPDYpQshqF25HiynWGtbfL3Y8BYoVxaFxhhD9XfTucvUok51
	t4EhMxBxqV7s4HgFjjMI6rPFclNCrayA7DKTiulF4mdps7w1wkhN/GafQhRWB2WBhYQSNTvimPq
	U4U5uHBrxst/u6THiFRMkNMMHa9h4dztC07QgaTsiO01kA2PulM/POgRLwwuO0ePAlh6/q6aGeD
	utTHHRX5EVcCICpgaE6QDcpukTtNfg5A/9C23ThZuCn2Mj5JzMWy88eWovKW4bMTPkDnruZJKkQ
	RQsVkDfE/jC8Hm1LTU7s8yFgkDkWQ/qXm75cnRpAHB3VdMVQH1t2d7DRRiG748xA3OlKorJ3Q5Z
	N/fWFiQDIVHnTuEneIUcvl/1Y1Qr6Al++HqDBVxlk+2ZOlIB8FujAilh4SHVSaqHigRokJ5O80R
	84+dH0rwlGzSZXQzig=
X-Received: by 2002:a05:6808:1994:b0:4d6:9355:7543 with SMTP id 5614622812f47-4d731545ff8mr956682b6e.62.1790209466617;
        Wed, 23 Sep 2026 17:24:26 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c1b305b8sm3689133b6e.1.2026.09.23.17.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 17:24:25 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:24:21 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: sgarzare@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, skhan@linuxfoundation.org, stefanha@redhat.com,
	mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, rdunlap@infradead.org,
	donald.hunter@gmail.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, sargun@sargun.me, jlinbox@meta.com,
	sdf.kernel@gmail.com, bobbyeshleman@meta.com
Subject: Re: [PATCH net-next v2 6/6] selftests/vsock: test the netns assign
 privilege checks
Message-ID: <arRttf9k4yKahe4R@devvm29614.prn0.facebook.com>
References: <20260921-vsock-guest-ns-v2-6-693bd78fde9e@meta.com>
 <179019126776.2160803.16648507383433583043@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179019126776.2160803.16648507383433583043@kernel.org>

On Wed, Sep 23, 2026 at 07:21:07PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] Both new selftests
>   (`test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails`,…
> - [Low] The two new shared-VM tests omit the `vm_reset_g2h()` cleanup
>   that every other ns_guest_assign_g2h_netns_* test in USE_SHARED_VM…
> 
> --
> 
> selftests/vsock: test the netns assign privilege checks
> 
> Adds two vmtest.sh cases that attempt VSOCK_CMD_DEV_NETNS_SET without
> CAP_NET_ADMIN and from an unprivileged user namespace, and enables
> CONFIG_USER_NS in the vsock selftest config.
> 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index e94cc2fd90ccd..4f42bcdac3f6c 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> 
> [ ... ]
> 
> > @@ -187,6 +195,8 @@ readonly TEST_DESCS=(
> >  	ns_guest_assign_g2h_netns_host_connect_ok
> >  	ns_guest_assign_g2h_netns_reset_on_ns_delete_ok
> >  	ns_guest_assign_g2h_netns_old_conn_send_fails
> > +	ns_guest_assign_g2h_netns_no_cap_net_admin_fails
> > +	ns_guest_assign_g2h_netns_unpriv_user_ns_fails
> >  )
> >  readonly NS_MODES=("local" "global")
> 
> [Severity: Low]
> Both new tests are added to USE_SHARED_VM but neither calls
> vm_reset_g2h() on any exit path, unlike every other
> ns_guest_assign_g2h_netns_* test in that list.
> 
> Should these follow the sibling pattern?  If the privilege check under
> test is broken, the assign succeeds and the guest's single g2h device is
> left owned by the transient namespace created by unshare, while the
> harness moves on to the next test in the same VM.
> 
> The kernel does restore this by itself once that namespace is reaped:
> 
> net/vmw_vsock/af_vsock.c:vsock_g2h_net_reset() {
> 	if (likely(rcu_access_pointer(vsock_g2h_net) != net))
> 		return;
> 
> 	mutex_lock(&vsock_register_mutex);
> 	if (rcu_access_pointer(vsock_g2h_net) == net)
> 		rcu_assign_pointer(vsock_g2h_net, &init_net);
> 	...
> }
> 
> registered as .pre_exit in vsock_pernet_ops, and the next test's
> vm_ns_assign_g2h() overwrites the pointer anyway.  The residual window is
> the asynchronous teardown that ..._reset_on_ns_delete_ok already documents
> ("the namespace itself is dismantled from a workqueue, so the device does
> not come back the same instant").  Since the new tests are appended last
> in TEST_NAMES and USE_SHARED_VM, a default run is unaffected; this only
> shows up with selective or reordered invocation.

Yes, these tests should call it regardless. Relying on cleanup makes the
pass/fail race-y.

> 
> [ ... ]
> 
> > @@ -1832,6 +1842,48 @@ test_ns_guest_assign_g2h_netns_reset_on_ns_delete_ok() {
> >  	return "${KSFT_PASS}"
> >  }
> >  
> > +test_ns_guest_assign_g2h_netns_no_cap_net_admin_fails() {
> > +	local cmd="unshare -n setpriv --bounding-set=-net_admin"
> > +	local rc
> > +
> > +	vm_ssh "init_ns" -- "${cmd}" python3 /root/ynl/cli.py --no-schema \
> > +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> > +	rc=$?
> > +
> > +	if [[ "${rc}" -eq 0 ]]; then
> > +		log_host "assign unexpectedly succeeded without CAP_NET_ADMIN"
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	return "${KSFT_PASS}"
> > +}
> 
> [Severity: Medium]
> Can this test pass without the capability check ever being reached?  The
> only assertion is rc -eq 0 => FAIL, output is discarded with &>/dev/null,
> and there is no positive control, so any nonzero status reads as
> KSFT_PASS.
> 
> A few concrete sources of a nonzero status that are not -EPERM:
> 
> net/vmw_vsock/af_vsock.c:vsock_nl_dev_netns_set_doit() {
> 	int err = vsock_g2h_net_assign(genl_info_net(info));
> 
> 	if (err == -ENODEV)
> 		NL_SET_ERR_MSG(info->extack,
> 			       "no guest-to-host transport is loaded");
> 	else if (err == -EOPNOTSUPP)
> 	...
> }
> 
> and cli.py collapses all of those to the same status as -EPERM:
> 
> tools/net/ynl/pyynl/cli.py:main() {
>     except NlError as e:
>         print(e)
>         sys.exit(1)
> }
> 
> vm_ssh() also returns ssh's own status, so a transport failure (255) or a
> remote shell failure (127, e.g. an installed util-linux that does not
> accept setpriv --bounding-set=-net_admin) is indistinguishable from the
> expected refusal.  A python-side failure such as a missing
> /root/ynl/vsock.yaml exits 1 too.
> 
> Would it be worth asserting the privileged case succeeds first?  The file
> already has the helper the sibling tests use as a precondition:
> 
> vm_ns_assign_g2h() {
> 	local ns=$1
> 	local nspid=$2
> 
> 	vm_ns_exec "${ns}" "${nspid}" "python3 /root/ynl/cli.py --no-schema \
> 		--spec /root/ynl/vsock.yaml --do dev-netns-set"
> }
> 
> On the changelog note "ynl's cli.py does not report the errno": is that
> accurate?  NlError.__str__() in tools/net/ynl/pyynl/lib/ynl.py does:
> 
>         msg += os.strerror(self.error)
> 
> so the error string is printed and the test could match "Operation not
> permitted" instead of sending everything to /dev/null.

I considered this but felt like grepping stderr/stdout is somewhat
unnatural. My plan was to later propose that cli.py returns the err via
exit code, and then update these tests.

First checking the privileged assign sounds like a reasonable middle
ground to rule out the other error states.

> 
> > +
> > +test_ns_guest_assign_g2h_netns_unpriv_user_ns_fails() {
> > +	local unpriv_uid=65534
> > +	local unpriv
> > +	local rc
> > +
> > +	unpriv="setpriv --reuid=${unpriv_uid} --regid=${unpriv_uid}"
> > +	unpriv="${unpriv} --clear-groups"
> > +
> > +	if ! vm_ssh "init_ns" -- "${unpriv} unshare -U true"; then
> > +		log_host "unprivileged user namespaces unavailable, skipping"
> > +		return "${KSFT_SKIP}"
> > +	fi
> > +
> > +	vm_ssh "init_ns" -- "${unpriv} unshare -Urn" \
> > +		python3 /root/ynl/cli.py --no-schema \
> > +		--spec /root/ynl/vsock.yaml --do dev-netns-set &>/dev/null
> > +	rc=$?
> > +
> > +	if [[ "${rc}" -eq 0 ]]; then
> > +		log_host "assign unexpectedly succeeded for unprivileged user"
> > +		return "${KSFT_FAIL}"
> > +	fi
> > +
> > +	return "${KSFT_PASS}"
> > +}
> 
> [Severity: Medium]
> Same rc != 0 => KSFT_PASS inference here, plus the availability probe is
> not the command being measured:
> 
> 	probe:    ${unpriv} unshare -U true
> 	measured: ${unpriv} unshare -Urn python3 /root/ynl/cli.py ...
> 
> If the extra -r/-n setup or the python startup under uid 65534 fails, the
> result is KSFT_PASS rather than KSFT_SKIP or KSFT_FAIL, and the child user
> namespace never actually holds CAP_NET_ADMIN, which is the condition the
> commit message says is being tested:
> 
>     the other confirms that CAP_NET_ADMIN in an unprivileged user ns
>     alone is insufficient.
> 
> Would checking the reported error string, or asserting the privileged
> assign works in the same test, make these two cases fail if
> GENL_ADMIN_PERM is ever dropped from VSOCK_CMD_DEV_NETNS_SET?

Yep, can follow the same approach as above.
