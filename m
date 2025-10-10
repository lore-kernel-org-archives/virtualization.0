Received: from r3-24.sinamail.sina.com.cn (r3-24.sinamail.sina.com.cn [202.108.3.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1A3D76
	for <virtualization@lists.linux.dev>; Fri, 10 Oct 2025 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067533; cv=none; b=j7e0Yy6RMIHxiX442kWCGRkCdS8jjmd+8TbDLkPAfHieaA9TNW9Se1X6nNNhjBznBRO45LcYiFT+S6gI3kzjFYCO+QestDhLY5TWZeyVWT9IFAdGEg+0zHSt4dlSH7p+TDVqkbLH8VBPZ4GjxK6GQohoho8RWEsE2M8X49vbRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067533; c=relaxed/simple;
	bh=8Ecs8UZeH+b4SFAAI+6b36v7Q78syLPFPq0fwyqiMLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PP7A4/r0w47TVaY7mCLWB1V1l05YPomMAf7SfvdwJJ2s0/oCF5+YA43WpQh0KcLdtsmalIs7PqrRPGfklBAmvN1Dhdd+ZPWc0Np5o90T059nxmCAW+qyPuFE+Hhqmoa0NYheJyF0Z5QkukCEtEJ/W4X2KzSu2DWNROljFLiIExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LxOuRFg4; arc=none smtp.client-ip=202.108.3.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LxOuRFg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1760067529;
	bh=EOWtoEy/CENb7q7Vmbx0hb+czVRDYnfp98ILfotb5W0=;
	h=From:Subject:Date:Message-ID;
	b=LxOuRFg4c33EpHdFY1XZqc7uYrWgWj2L/yQL+0uDjVGI6lE8GPYWbZ+ADHlK6gDQm
	 fpEn4SzQfneuObojP2TI1t66AwvTfwnPcxwyzjiJoeXrx6YUFTukncdfkD7+byWg5Q
	 JV3qtB2HWVaskOFIYs6VPcBsFQnL56C1I1p1JNc0=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 68E87E7E00005A32; Fri, 10 Oct 2025 11:33:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4028846816270
X-SMAIL-UIID: 73ADCBB3595B4B0BA3BBAF15F56B7D5C-20251010-113322-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+665739f456b28f32b23d@syzkaller.appspotmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev
Subject: Re: [syzbot] [net?] [virt?] BUG: sleeping function called from invalid context in __set_page_owner
Date: Fri, 10 Oct 2025 11:33:02 +0800
Message-ID: <20251010033310.8501-1-hdanton@sina.com>
In-Reply-To: <68e7e6e3.050a0220.1186a4.0001.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Thu, 09 Oct 2025 09:46:27 -0700	[thread overview]
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ec714e371f22 Merge tag 'perf-tools-for-v6.18-1-2025-10-08'..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=174a4b34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=db9c80a8900dca57
> dashboard link: https://syzkaller.appspot.com/bug?extid=665739f456b28f32b23d
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e0dcd980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1581452f980000

Test Alexei's fix.

#syz test

--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -168,6 +168,9 @@ static void add_stack_record_to_list(struct stack_record *stack_record,
 	unsigned long flags;
 	struct stack *stack;
 
+	if (!gfpflags_allow_spinning(gfp_mask))
+		return;
+
 	set_current_in_page_owner();
 	stack = kmalloc(sizeof(*stack), gfp_nested_mask(gfp_mask));
 	if (!stack) {
--
