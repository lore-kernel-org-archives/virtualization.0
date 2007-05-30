From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 17:03:33 -0500
Message-ID: <465DF4B5.40705__44950.4020777114$1180562663$gmane$org@us.ibm.com>
References: <97D612E30E1F88419025B06CB4CF1BE10259AE6D@scsmsx412.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <97D612E30E1F88419025B06CB4CF1BE10259AE6D@scsmsx412.amr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Nakajima, Jun wrote:
> Anthony Liguori wrote:
>   
>
> Given the optimizations for CPU virtualization in the current H/W, I'm
> not sure if such hooks are useful. Do you have any performance data that
> justify such hooks? 
>   

No, I don't.  It was just a thought that was yet to be confirmed.

Regards,

Anthony Liguori

>> Regards,
>>
>> Anthony Liguori
>>
>>     
>
>
> Jun
> ---
> Intel Open Source Technology Center
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>
>   
