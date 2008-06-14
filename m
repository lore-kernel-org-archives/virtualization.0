From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH] Do not calculate linear rip in emulation failure report
Date: Sat, 14 Jun 2008 08:01:58 +0300
Message-ID: <485350C6.8010601__38996.3297792294$1213419860$gmane$org@qumranet.com>
References: <1213105613-8571-1-git-send-email-gcosta@redhat.com>	
	<52d4a3890806131033g56ec2bc0o43442d2c290401f2@mail.gmail.com>	
	<5d6222a80806131037u245c66ev902fadaa6d5c4605@mail.gmail.com>	
	<4852CE93.9020104@qumranet.com>	
	<5d6222a80806131251q12fbbff0rc90a133722acf2d7@mail.gmail.com>	
	<4853298C.7090109@qumranet.com>
	<5d6222a80806132043x621ec290sbfd42e33e06843b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5d6222a80806132043x621ec290sbfd42e33e06843b5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <glommer@gmail.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Glauber Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Glauber Costa wrote:
> I don't think so. It wasn't enough messages to DoS the system.
> Just enough messages to annoy me.
>   

If emulation failure messages annoy you, I'm sure you can think of a way 
of removing them other than tampering with kvm_report_emulation_failure().



-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
