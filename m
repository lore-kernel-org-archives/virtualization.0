Return-Path: <SRS0=OSH5=O3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D04C433F5
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 09:35:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2113B611C1
	for <virtualization@archiver.kernel.org>; Thu,  7 Oct 2021 09:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2113B611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFB6B60F6D;
	Thu,  7 Oct 2021 09:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QUPtAULYY-FV; Thu,  7 Oct 2021 09:35:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 911A1606BA;
	Thu,  7 Oct 2021 09:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67EC1C000F;
	Thu,  7 Oct 2021 09:35:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CACD4C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 09:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9E978408D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 09:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xGuSqHzFYP6X
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 09:35:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1890284033
 for <virtualization@lists.linux-foundation.org>;
 Thu,  7 Oct 2021 09:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633599347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLM20CrNDiSc8ANWHfJkU17zM0jd+LCsGgIfHq5T3Hk=;
 b=Tqll9fl/Bem9JQ3Vj3cBLb2r+fV7dEMU169tVNnFvkqaN8wfdzkrKpecCZdVGfMggBA9sq
 +6WXFbin4IhuO5Cnk8C+0/Urf7K7rBf/6W7MKv1WTaWLtKCbauvxOx6bpXxTf9KiQvb5eD
 /VrusPQE5W+hI0YPIvKLQRLEWz2GElk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-WkW6tF3NNrKJSWWv7lcPbw-1; Thu, 07 Oct 2021 05:35:47 -0400
X-MC-Unique: WkW6tF3NNrKJSWWv7lcPbw-1
Received: by mail-wr1-f71.google.com with SMTP id
 r21-20020adfa155000000b001608162e16dso4191137wrr.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 07 Oct 2021 02:35:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=YLM20CrNDiSc8ANWHfJkU17zM0jd+LCsGgIfHq5T3Hk=;
 b=VrmHQjEoucoljSR8O3j45XhaXvcM0RneDxaW+Y06Wc7Gao9T3az7kaJSngFA/OlXCO
 pKz828Qqz4ygTTs3EOewaB6RtjCZ/qbFPz/UYvyjpJFFr5MozzsEXqKY+OV9hlnLW5s3
 6PEAOoqQTKfLfbTiVsN39HjDmEpjA1lmWYh8bHs9ah6Psv4xDU3QpzJxUYoCIvmfk2ep
 AByAbY9zN7Mwus6znS0P6K3nhcgIRv880OQlpKvAYkREklFoIwWMDlYsoC7CGgp9cjnm
 SkV8b2TvKru9vhkrlyEYkZ8pdYrquy3agx907CPFW7qkDl3xk1bXBq6JmT7SU1GyumvU
 fQeA==
X-Gm-Message-State: AOAM5306WkhHOjReGwFlqYv/bs7dd8Lzc4rcTPQVJYxS88vIqEX6oOqV
 Hunyp0vUWqiMSCsFrZmM0RgfUkPd7FLumiBB6Jobigepr7PEpWvnD5GvFnwLKGTQHQ0EDQfZFWa
 /9fYNb8QF8zZzymag2ye0i/PAh20T3ayEAOZb+el+mNNL6dXl/GTMZnsKbfOd3MiJ4Y5pbYuS9i
 fZCSb2lz8tnCujcg==
X-Received: by 2002:adf:a118:: with SMTP id o24mr3898259wro.15.1633598859401; 
 Thu, 07 Oct 2021 02:27:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTkTGQO7OWYf67tE5FRQkAoLSad774DWcZLIKG1RX8coeD4jn+lqAsFsAow6Xbu9zf7PRTow==
X-Received: by 2002:adf:a118:: with SMTP id o24mr3898207wro.15.1633598859138; 
 Thu, 07 Oct 2021 02:27:39 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6886.dip0.t-ipconnect.de. [91.12.104.134])
 by smtp.gmail.com with ESMTPSA id l17sm23582725wrx.24.2021.10.07.02.27.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Oct 2021 02:27:38 -0700 (PDT)
Subject: Re: [PATCH v1 6/6] x86: remove memory hotplug support on X86_32
To: Oscar Salvador <osalvador@suse.de>
References: <20210929143600.49379-1-david@redhat.com>
 <20210929143600.49379-7-david@redhat.com>
 <YV66zoLEP3niIHEu@localhost.localdomain>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <565bdc3e-04b2-8eff-181c-d4dcf82e0e40@redhat.com>
Date: Thu, 7 Oct 2021 11:27:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YV66zoLEP3niIHEu@localhost.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, linux-kselftest@vger.kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Mike Rapoport <rppt@kernel.org>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 07.10.21 11:15, Oscar Salvador wrote:
> On Wed, Sep 29, 2021 at 04:36:00PM +0200, David Hildenbrand wrote:
>> CONFIG_MEMORY_HOTPLUG was marked BROKEN over one year and we just
>> restricted it to 64 bit. Let's remove the unused x86 32bit implementation
>> and simplify the Kconfig.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks for the review Oscar!

-- 
Thanks,

David / dhildenb

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
