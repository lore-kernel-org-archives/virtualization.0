From: Glauber Costa <gcosta@redhat.com>
Subject: Re: [PATCH 0/3 - resend] kvmclock reboot
Date: Tue, 18 Mar 2008 08:02:42 -0300
Message-ID: <47DFA152.7080901__40869.6800390773$1205838560$gmane$org@redhat.com>
References: <1205836206192-git-send-email-gcosta@redhat.com>
	<47DF9ED3.2070302@qumranet.com> <47DF9FAB.6030604@redhat.com>
	<47DFA0BF.4020405@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47DFA0BF.4020405@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, akpm@linux-foundation.org, anthony@codemonkey.ws, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Avi Kivity wrote:
> Glauber Costa wrote:
>>>
>>> [Once a patchset has been applied and pushed (as seen on 
>>> kvm-commits), I prefer incremental patches]
>>>
>> But I think this is a very good case of an exception, since the 
>> applied patches would break bisect. I prefer to hear "damn glommer!" 
>> because of that than "damn glommer!!" because of a broken bisect.
> 
> I fold them up before sending to Linus anyway, so upstream bisect 
> continues to work.  For kvm.git, it's a choice between rewinding it a 
> bit (which may confuse anyone who pulls) and breaking bisect.
> 
> 
ok, this wfm. I'll send incrementally next time.
