From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH/RFC 0/2] CPU hotplug virtio driver
Date: Wed, 09 Jan 2008 16:37:29 +0200
Message-ID: <4784DC29.1020907__7292.92815453864$1199889614$gmane$org@qumranet.com>
References: <11998740663306-git-send-email-gcosta@redhat.com>
	<200801091227.12261.borntraeger@de.ibm.com>
	<4784D882.1030104@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4784D882.1030104@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: Marcelo Tosatti <marcelo@kvack.org>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net
List-Id: virtualization@lists.linuxfoundation.org

Glauber de Oliveira Costa wrote:
>
> That said, if acpi is really the preference here, and this patches 
> have chance, no problem. But it will take me a little more time to 
> implement them ;-)

The power button support that was recently added at least proves that 
the host->guest notification path works, so that's one tooth that does 
not need pulling out.  The real trouble with acpi is understanding the 
spec which is very badly written.

_AVI

-- 
error compiling committee.c: too many arguments to function
