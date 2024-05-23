Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BC5537FF
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489901; cv=none; b=HBq7e5Hu0f6H+kR4d1z/VOdtiWVqwSV1d2/fcXmUNEPj9OnFZlVLx+MV/yb/1GmzUXdNI24rHfpduIEijptrFtSbjYkX3uVB21ZRUgT0tInnl6UQ4hBLvfWDcucZKLDvun8TxzfaRIgP9nQokbpK7ETsSpAx1Z3amRyUoQqI1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489901; c=relaxed/simple;
	bh=TI3pdmAKg+5yVM5dLTNR68lA0tJx6Al4lndldRk3nlc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=XC4znufZ0KdlKagksvTRZDuMAn1Y3moFqkwCSkucjf/NVXtKOckna9noGUwbOwzI6y0AdSq/POuskZkNJqwA3lFgFKi0x6MVW2RpDo1upBWeD2dCfZXrYcdyrgYpp76jqKBKpisYrkaetYDY9WWJH3A6CyiV6s32b8rY7pCnjLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNfVPlq3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNfVPlq3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716489900; x=1748025900;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=TI3pdmAKg+5yVM5dLTNR68lA0tJx6Al4lndldRk3nlc=;
  b=nNfVPlq3RqustLDBCiUq5et/b3xFDnDrD3WhEux2Vexab0g91cFxwMYa
   5m9FJhW9/ILgrvnW7cpNNo30Tv4z+yMtBnGfigNvy3SXwzK8gcs+v6lYf
   PL2i7oHIJ4FTa69bozr0roR8IIJuC//e5pxz0aECk4xkfU0pEhwB8KNMv
   XVoe9uAu6o1bUrjkFRnRqmAY16SvnFbPGLkiMJ71pGpqEwj7mKEv6NzAZ
   6A6QO8Ch9/f1wyQN2ec9WuHxRyok/PuUPpF1NmCT+S0Q1X51q+k3Tpdp6
   pZeJxQHpOc5fkdPOKM5ZD/MUhi1DAk/N2IRMQ1aROfi0RM0Iw2vX1qjRD
   A==;
X-CSE-ConnectionGUID: hNt75RgnQ7++5zrg0KQLXA==
X-CSE-MsgGUID: DaWQ/y+gROCS5RWjoh50Vg==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="38212101"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="38212101"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 11:45:00 -0700
X-CSE-ConnectionGUID: lKO59ISPQGOMy5xKHNmM0Q==
X-CSE-MsgGUID: Xeja5Z5GSBudXxWMVrrtog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33836181"
Received: from kinlongk-desk.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 11:44:59 -0700
Content-Type: multipart/mixed; boundary="------------A4UK60YqxMGh0ck0hw0N0zV1"
Message-ID: <23454ac4-1dbc-4c03-9df2-fcf35da493e4@intel.com>
Date: Thu, 23 May 2024 11:44:58 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/paravirt: Disable virt spinlock when
 CONFIG_PARAVIRT_SPINLOCKS disabled
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 Chen Yu <yu.c.chen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.amakhalov@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Prem Nath Dey <prem.nath.dey@intel.com>,
 Xiaoping Zhou <xiaoping.zhou@intel.com>
References: <20240516130244.893573-1-yu.c.chen@intel.com>
 <7b8d1dd6-3913-45fe-941e-aac2c15916dc@intel.com>
 <ec8b5d13-3034-4255-ace3-cf1564646da9@suse.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <ec8b5d13-3034-4255-ace3-cf1564646da9@suse.com>

This is a multi-part message in MIME format.
--------------A4UK60YqxMGh0ck0hw0N0zV1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/23/24 11:39, Jürgen Groß wrote:
>>
>> Let's just keep it simple.  How about the attached patch?
> 
> Simple indeed. The attachment is empty. 😛

Let's try this again.
--------------A4UK60YqxMGh0ck0hw0N0zV1
Content-Type: text/x-patch; charset=UTF-8; name="pv.patch"
Content-Disposition: attachment; filename="pv.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9wYXJhdmlydC5jIGIvYXJjaC94ODYva2Vy
bmVsL3BhcmF2aXJ0LmMKaW5kZXggNTM1OGQ0Mzg4NmFkLi5jMTkzYzllNjBhMWIgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9wYXJhdmlydC5jCisrKyBiL2FyY2gveDg2L2tlcm5l
bC9wYXJhdmlydC5jCkBAIC01NSw4ICs1NSw3IEBAIERFRklORV9TVEFUSUNfS0VZX1RSVUUo
dmlydF9zcGluX2xvY2tfa2V5KTsKIAogdm9pZCBfX2luaXQgbmF0aXZlX3B2X2xvY2tfaW5p
dCh2b2lkKQogewotCWlmIChJU19FTkFCTEVEKENPTkZJR19QQVJBVklSVF9TUElOTE9DS1Mp
ICYmCi0JICAgICFib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpCisJaWYg
KCFib290X2NwdV9oYXMoWDg2X0ZFQVRVUkVfSFlQRVJWSVNPUikpCiAJCXN0YXRpY19icmFu
Y2hfZGlzYWJsZSgmdmlydF9zcGluX2xvY2tfa2V5KTsKIH0KIAo=

--------------A4UK60YqxMGh0ck0hw0N0zV1--
