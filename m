Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF75331DD97
	for <virtualization@lists.linux.dev>; Wed,  5 Nov 2025 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359095; cv=none; b=H3H87+p6AcaYXblPFEPswszyZ91ThPX7zbgScIjhh12W2YxXb0m6wNaCERFyK5uApIWD8racvhp3OVYG3TEuZR2N4Y3BbtAfX9B/ztLJK0Ws0XoK/9DkFC7ie4g3U6Um3q9zAa1ivZPMBLycrvHpMxFr5ZpZvxYIJ79/KI1efxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359095; c=relaxed/simple;
	bh=W3rIEqDAjFHWAwm+pwB74Wz+AVL3IfQgKO4Y4lo7W2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6NB33njjTku9B9LCI+A86fJIVhlr25Zo1sJc7A03a6hAFt6BJnIM9BIMoNj4He9Opts4lrvbH6+8JYs7Hq1EYoKH8EPd4BVHTnY44/SKqgE4nKqZHTlL/73rrJvJnmXK1/+Z+fjB5mYMzkUb7JToxETx/MS68tkjU1DmceL0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maQrijod; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maQrijod"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7815092cd0bso89029757b3.2
        for <virtualization@lists.linux.dev>; Wed, 05 Nov 2025 08:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762359093; x=1762963893; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ymZ6xdXrqo7vWAgf0QChueJMpmkC1T045PA4GVzRwIo=;
        b=maQrijodR7F4R5BDBYwGzWaMbkSxU3SrizJpWWdjRz7cR7Q6F3UtTqCJVwm1DBcajO
         uHW7D65ja7hS1IjlP6A3zHtwgBrtQlYaz36W9hXNDFBWQaYevLpNSyY4F+alMvfCbAyf
         BCkgQKi/Y7W0EN4bJtGUWH2fkPv6ETISTEucJ1LP4CRATmSIngcrX9uA741bzx48XmiQ
         k1QMHTGsccaCq8XxvWp/8Y2eJ+R52t84yeMKsL/cQslPmJqQwHRBZPNTOB4p2XwQhjG8
         j0OtrULrGoj7tq3/hCh15ByvYyA3UM1T/C+94i6oPiSFUVRqTLf8X+XMy4aMjyPuBssf
         fg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359093; x=1762963893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymZ6xdXrqo7vWAgf0QChueJMpmkC1T045PA4GVzRwIo=;
        b=auKr8My2sy0faydQyeC2V6PCSDSOzWs580n0L5la3lbOvuZBbXOuWei0YaQyoGZJbx
         uBxjhfpjB5doDEGgNI+m5JnF0Tv2pqXqCvcubfh4Dm35W6iXHeZt5Ewaoz79cLq0KhTw
         S7PHMZPNvsV3QWC19tDRi3rHgD0zethUOPifLDtWbNhHX9XeFZkCG2+7AENgEm4/CGpW
         NTcReKl11N5Ggb9u+w5eoxymiA+EKrglgDBGNLUgGojeRetA2muLDgtqeVwsXBgG4SLq
         GHxuWDa0v3z93DeiMAlO6MGGdAuGceSU65FECpkfr6siHNYxmCsKDtY3pGKFhRS+YcBm
         9qkw==
X-Forwarded-Encrypted: i=1; AJvYcCUP9WzYd9E13t6qINNUR86SmtJp2j2tLlgZDB6QzaTeUv90RyDqvqBKubyivzJFNQA90RqD8VltBLSoZp+PBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzA+WPJH+FaXmRh8QuoX1fLGt96r0rdH9fvTN9a/7qJxB3Yxreg
	kzIyvtgZdW6uQiqxYVf/rkopr+d4QqOoCwvmnsqBp7whrxy9NM/FynEe
X-Gm-Gg: ASbGncuzEkfutrmYF1wUuYFPKNwLQQEpo/XiaK28Jtl8WIrxwXE/4JTTDarLzOwFaWg
	wiDICoCXxl9bA6Bykxcyk/apo/7PLz5EAmLYvJl1dvC3ZlgYNGcjPVjLH8oxOjfsVB1T/Wtmbds
	6OP61xBUMPmARt2R8zvZA3G1vujUJ/rtaUM1M0Ko3d7V+D40NfOmIgatMeFVUPpdYwIdLv6uS9+
	nphY2IRHSBt0NS9k1QPYyD1czdNPFBnCLSWjdxOj2KIQZzRdkIk+daV2BTw2TNIQxGpbhBMRyQp
	/71kc2ATUc2EsJK5ak8MR4eGLkxiOR4KYr+osWMBpQ8L8oR43Z162pCMyto16kjc2S1Ex7hEoAA
	Tg3DR1krbiUIyREMwQ5vxX/tzMtXGm0z92jknC0v0Is0e0tw+5IwaSO5lETJTRQwizfLAGEx328
	8LUox5DhQl32Pxa9/jk2vwOXw2qqlEqrDWqsY=
X-Google-Smtp-Source: AGHT+IFO1Aj58ygyCOlI2zA+lUSTMddFikFOwBkJL3a+he6zkxfPMBnlF0h5B3IACmlOERHv2GNjEQ==
X-Received: by 2002:a05:690c:9a0a:b0:786:581d:f24b with SMTP id 00721157ae682-786a41e29cemr57871067b3.47.1762359092678;
        Wed, 05 Nov 2025 08:11:32 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78691d8f0b4sm20313777b3.4.2025.11.05.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:11:32 -0800 (PST)
Date: Wed, 5 Nov 2025 08:11:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] selftests/vsock: avoid false-positives when checking
 dmesg
Message-ID: <aQt3LitYPBcD0MM+@devvm11784.nha0.facebook.com>
References: <20251104-vsock-vmtest-dmesg-fix-v1-1-80c8db3f5dfe@meta.com>
 <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oqglacowaadnhai4ts4pn4khaumxyoedqb5pieiwsvkqtk7cpr@ltjbthajbxyq>

On Wed, Nov 05, 2025 at 12:16:42PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 01:50:50PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Sometimes VMs will have some intermittent dmesg warnings that are
> > unrelated to vsock. Change the dmesg parsing to filter on strings
> > containing 'vsock' to avoid false positive failures that are unrelated
> > to vsock. The downside is that it is possible for some vsock related
> > warnings to not contain the substring 'vsock', so those will be missed.
> > 
> > Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Previously was part of the series:
> > https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
> > ---
> > tools/testing/selftests/vsock/vmtest.sh | 8 ++++----
> > 1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
> > index edacebfc1632..e1732f236d14 100755
> > --- a/tools/testing/selftests/vsock/vmtest.sh
> > +++ b/tools/testing/selftests/vsock/vmtest.sh
> > @@ -389,9 +389,9 @@ run_test() {
> > 	local rc
> > 
> > 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
> > -	host_warn_cnt_before=$(dmesg --level=warn | wc -l)
> > +	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
> > 	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
> > -	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | wc -l)
> > +	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
> > 
> > 	name=$(echo "${1}" | awk '{ print $1 }')
> > 	eval test_"${name}"
> > @@ -403,7 +403,7 @@ run_test() {
> > 		rc=$KSFT_FAIL
> > 	fi
> > 
> > -	host_warn_cnt_after=$(dmesg --level=warn | wc -l)
> > +	host_warn_cnt_after=$(dmesg --level=warn | grep -c -i vsock)
> 
> In the previous hunk we quoted 'vsock', but here and in the next we did
> not. Can we be consistent at least in the same patch ?
> 
> The rest LGTM.
> 
> Stefano

Just sent the update, sorry for the oversight.

Best,
Bobby
