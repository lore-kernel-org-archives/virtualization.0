From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
Date: Fri, 10 Apr 2020 02:32:35 -0700
Message-ID: <37d755a7-8fc9-8cc8-5627-027a8479b6c7@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <d7f8bff3-526a-6a84-2e81-677cfbac0111@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d7f8bff3-526a-6a84-2e81-677cfbac0111@suse.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020-04-08 5:28 a.m., Jürgen Groß wrote:
> On 08.04.20 07:02, Ankur Arora wrote:
[ snip ]
> 
> Quite a lot of code churn and hacks for a problem which should not
> occur on a well administrated machine.
Yeah, I agree the patch set is pretty large and clearly the NMI or
the stop_machine() are completely out. That said, as I wrote in my
other mail I think the problem is still worth solving.

> Especially the NMI dependencies make me not wanting to Ack this series.
The NMI solution did turn out to be pretty ugly.

I was using it to solve two problems: avoid a deadlock where an NMI handler
could use a lock while the stop_machine() thread is trying to rewrite the
corresponding call-sites. And, needed to ensure that we don't lock
and unlock using mismatched primitives.


Thanks
Ankur

> 
> 
> Juergen
