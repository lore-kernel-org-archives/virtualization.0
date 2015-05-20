From: Vasile Catalin-B50542 <catalin.vasile@freescale.com>
Subject: Re: Trying to make VHOST-BLK to work
Date: Wed, 20 May 2015 13:01:58 +0300
Message-ID: <555C5B96.2010407@freescale.com>
References: <CADM6D_oUqgwvngrY-mNm_HQrfY_qoz-zJY5RMzGaKnCRYB4J7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5804435976077383832=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CADM6D_oUqgwvngrY-mNm_HQrfY_qoz-zJY5RMzGaKnCRYB4J7g@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sudheer K <sudheer.kurichiyath@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

--===============5804435976077383832==
Content-Type: multipart/alternative;
	boundary="------------010203000503020200040500"

--------------010203000503020200040500
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

There is no code in >>QEMU<< that actually triggers notifications to the 
guest when using vhost.
When you are using vhost, interrupts are triggered directly to the guest.
The interrupt lines are mapped as a shared memory, that don't pass 
through QEMU, if they don't have to.
Indeed, there is an initial setup in QEMU that makes this configuration.

Note:
The things that I am saying are somewhat deductions from what I've 
studied from the code myself and some answers
from qemu-devel (so I cannot assure you on the correctness of this 
answer), as the kvm and virtualization community themselves
aren't very active.

On 19.05.2015 14:13, Sudheer K wrote:
> Hi Kernel KVM folks and Michael,
>
> I am trying to make VHOST-BLK to work by myself since I did not hear 
> from Asias on my personal mail to him. I will be grateful to you for 
> your time and response.
>
> The problem I am seeing is there is no response seen by the VM through 
> the HOST has executed the IO successfully and issued 
> vhost_add_used_and_signal.  Here is my question. Which code in QEMU 
> issues virtio_notify() when the VHOST completes the IO in kernel?
>
> I have some related questions. Could I connect a iscsi LUN to a VM via 
> vhost-scsi? Could you please point me to some documents if there are any?
>
> Thanks and Regards
>
> Sudheer
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

-- 

CatalinVasile

Intern, DN-Software

FreescaleSemiconductor, Inc.

www.freescale.com

phone: 073-021-1938

e-mail: catalin.vasile@freescale.com <mailto:your.name@freescale.com>

*Freescale_Logo-nosemi_Lh_4c***

This e-mail, and any associated attachments have been classified as:

[ ] Public

[ ] Freescale Semiconductor Internal Use Only

[ ] Freescale Semiconductor Confidential Proprietary


--------------010203000503020200040500
Content-Type: multipart/related;
	boundary="------------070708010300010403020809"

--------------070708010300010403020809
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    There is no code in &gt;&gt;QEMU&lt;&lt; that actually triggers
    notifications to the guest when using vhost.<br>
    When you are using vhost, interrupts are triggered directly to the
    guest.<br>
    The interrupt lines are mapped as a shared memory, that don't pass
    through QEMU, if they don't have to.<br>
    Indeed, there is an initial setup in QEMU that makes this
    configuration.<br>
    <br>
    Note:<br>
    The things that I am saying are somewhat deductions from what I've
    studied from the code myself and some answers<br>
    from qemu-devel (so I cannot assure you on the correctness of this
    answer), as the kvm and virtualization community themselves<br>
    aren't very active.<br>
    <br>
    <div class=3D"moz-cite-prefix">On 19.05.2015 14:13, Sudheer K wrote:<=
br>
    </div>
    <blockquote
cite=3D"mid:CADM6D_oUqgwvngrY-mNm_HQrfY_qoz-zJY5RMzGaKnCRYB4J7g@mail.gmai=
l.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DISO-8859-1">
      <div dir=3D"ltr">
        <div>Hi Kernel KVM folks and Michael,<br>
          <br>
          I am trying to make VHOST-BLK to work by myself since I did
          not hear from Asias on my personal mail to him. I will be
          grateful to you for your time and response.<br>
          <br>
          The problem I am seeing is there is no response seen by the VM
          through the HOST has executed the IO successfully and issued
          vhost_add_used_and_signal.=C2=A0 Here is my question. Which cod=
e in
          QEMU issues virtio_notify() when the VHOST completes the IO in
          kernel?<br>
          <br>
          I have some related questions. Could I connect a iscsi LUN to
          a VM via vhost-scsi? Could you please point me to some
          documents if there are any?<br>
          <br>
          Thanks and Regards<br>
          <br>
        </div>
        Sudheer<br>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
Virtualization mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:Virtualization@lists=
.linux-foundation.org">Virtualization@lists.linux-foundation.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.linuxfoundation.=
org/mailman/listinfo/virtualization">https://lists.linuxfoundation.org/ma=
ilman/listinfo/virtualization</a></pre>
    </blockquote>
    <br>
    <div class=3D"moz-signature">-- <br>
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DISO-8859-1">
      <meta name=3D"ProgId" content=3D"Word.Document">
      <meta name=3D"Generator" content=3D"Microsoft Word 12">
      <meta name=3D"Originator" content=3D"Microsoft Word 12">
      <link rel=3D"File-List" href=3D"email_signature_files/filelist.xml"=
>
      <link rel=3D"Edit-Time-Data"
        href=3D"email_signature_files/editdata.mso">
      <!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:DocumentProperties>
  <o:Author>Catalin Vasile</o:Author>
  <o:LastAuthor>Catalin Vasile</o:LastAuthor>
  <o:Revision>2</o:Revision>
  <o:TotalTime>1</o:TotalTime>
  <o:Created>2014-07-01T07:39:00Z</o:Created>
  <o:LastSaved>2014-07-01T07:39:00Z</o:LastSaved>
  <o:Pages>1</o:Pages>
  <o:Words>54</o:Words>
  <o:Characters>313</o:Characters>
  <o:Company>Freescale</o:Company>
  <o:Lines>2</o:Lines>
  <o:Paragraphs>1</o:Paragraphs>
  <o:CharactersWithSpaces>366</o:CharactersWithSpaces>
  <o:Version>12.00</o:Version>
 </o:DocumentProperties>
</xml><![endif]-->
      <link rel=3D"themeData" href=3D"email_signature_files/themedata.thm=
x">
      <link rel=3D"colorSchemeMapping"
        href=3D"email_signature_files/colorschememapping.xml">
      <!--[if gte mso 9]><xml>
 <w:WordDocument>
  <w:SpellingState>Clean</w:SpellingState>
  <w:GrammarState>Clean</w:GrammarState>
  <w:TrackMoves>false</w:TrackMoves>
  <w:TrackFormatting/>
  <w:PunctuationKerning/>
  <w:ValidateAgainstSchemas/>
  <w:SaveIfXMLInvalid>false</w:SaveIfXMLInvalid>
  <w:IgnoreMixedContent>false</w:IgnoreMixedContent>
  <w:AlwaysShowPlaceholderText>false</w:AlwaysShowPlaceholderText>
  <w:DoNotPromoteQF/>
  <w:LidThemeOther>EN-US</w:LidThemeOther>
  <w:LidThemeAsian>X-NONE</w:LidThemeAsian>
  <w:LidThemeComplexScript>X-NONE</w:LidThemeComplexScript>
  <w:Compatibility>
   <w:BreakWrappedTables/>
   <w:SnapToGridInCell/>
   <w:WrapTextWithPunct/>
   <w:UseAsianBreakRules/>
   <w:DontGrowAutofit/>
   <w:SplitPgBreakAndParaMark/>
   <w:DontVertAlignCellWithSp/>
   <w:DontBreakConstrainedForcedTables/>
   <w:DontVertAlignInTxbx/>
   <w:Word11KerningPairs/>
   <w:CachedColBalance/>
  </w:Compatibility>
  <w:BrowserLevel>MicrosoftInternetExplorer4</w:BrowserLevel>
  <m:mathPr>
   <m:mathFont m:val=3D"Cambria Math"/>
   <m:brkBin m:val=3D"before"/>
   <m:brkBinSub m:val=3D"&#45;-"/>
   <m:smallFrac m:val=3D"off"/>
   <m:dispDef/>
   <m:lMargin m:val=3D"0"/>
   <m:rMargin m:val=3D"0"/>
   <m:defJc m:val=3D"centerGroup"/>
   <m:wrapIndent m:val=3D"1440"/>
   <m:intLim m:val=3D"subSup"/>
   <m:naryLim m:val=3D"undOvr"/>
  </m:mathPr></w:WordDocument>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <w:LatentStyles DefLockedState=3D"false" DefUnhideWhenUsed=3D"true"
  DefSemiHidden=3D"true" DefQFormat=3D"false" DefPriority=3D"99"
  LatentStyleCount=3D"267">
  <w:LsdException Locked=3D"false" Priority=3D"0" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Normal"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"heading 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 7"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 8"/>
  <w:LsdException Locked=3D"false" Priority=3D"9" QFormat=3D"true" Name=3D=
"heading 9"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 7"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 8"/>
  <w:LsdException Locked=3D"false" Priority=3D"39" Name=3D"toc 9"/>
  <w:LsdException Locked=3D"false" Priority=3D"35" QFormat=3D"true" Name=3D=
"caption"/>
  <w:LsdException Locked=3D"false" Priority=3D"10" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Title"/>
  <w:LsdException Locked=3D"false" Priority=3D"1" Name=3D"Default Paragra=
ph Font"/>
  <w:LsdException Locked=3D"false" Priority=3D"11" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtitle"/>
  <w:LsdException Locked=3D"false" Priority=3D"0" Name=3D"Hyperlink"/>
  <w:LsdException Locked=3D"false" Priority=3D"22" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Strong"/>
  <w:LsdException Locked=3D"false" Priority=3D"20" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"59" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Table Grid"/>
  <w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Place=
holder Text"/>
  <w:LsdException Locked=3D"false" Priority=3D"1" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"No Spacing"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 1"/>
  <w:LsdException Locked=3D"false" UnhideWhenUsed=3D"false" Name=3D"Revis=
ion"/>
  <w:LsdException Locked=3D"false" Priority=3D"34" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"List Paragraph"/>
  <w:LsdException Locked=3D"false" Priority=3D"29" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Quote"/>
  <w:LsdException Locked=3D"false" Priority=3D"30" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Quote"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 1"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 2"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 3"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 4"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 5"/>
  <w:LsdException Locked=3D"false" Priority=3D"60" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Shading Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"61" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light List Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"62" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Light Grid Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"63" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 1 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"64" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Shading 2 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"65" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 1 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"66" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium List 2 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"67" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 1 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"68" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 2 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"69" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Medium Grid 3 Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"70" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Dark List Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"71" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Shading Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"72" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful List Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"73" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" Name=3D"Colorful Grid Accent 6"/>
  <w:LsdException Locked=3D"false" Priority=3D"19" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"21" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Emphasis"/>
  <w:LsdException Locked=3D"false" Priority=3D"31" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Subtle Reference"/>
  <w:LsdException Locked=3D"false" Priority=3D"32" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Intense Reference"/>
  <w:LsdException Locked=3D"false" Priority=3D"33" SemiHidden=3D"false"
   UnhideWhenUsed=3D"false" QFormat=3D"true" Name=3D"Book Title"/>
  <w:LsdException Locked=3D"false" Priority=3D"37" Name=3D"Bibliography"/=
>
  <w:LsdException Locked=3D"false" Priority=3D"39" QFormat=3D"true" Name=3D=
"TOC Heading"/>
 </w:LatentStyles>
</xml><![endif]-->
      <style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;
	mso-font-charset:1;
	mso-generic-font-family:roman;
	mso-font-format:other;
	mso-font-pitch:variable;
	mso-font-signature:0 0 0 0 0 0;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;
	mso-font-charset:0;
	mso-generic-font-family:swiss;
	mso-font-pitch:variable;
	mso-font-signature:-520081665 -1073717157 41 0 66047 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{mso-style-unhide:no;
	mso-style-qformat:yes;
	mso-style-parent:"";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
a:link, span.MsoHyperlink
	{mso-style-noshow:yes;
	color:blue;
	text-decoration:underline;
	text-underline:single;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-noshow:yes;
	mso-style-priority:99;
	color:purple;
	mso-themecolor:followedhyperlink;
	text-decoration:underline;
	text-underline:single;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	mso-pagination:widow-orphan;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-unhide:no;
	mso-style-locked:yes;
	mso-style-link:"Balloon Text";
	mso-ansi-font-size:8.0pt;
	mso-bidi-font-size:8.0pt;
	font-family:"Tahoma","sans-serif";
	mso-ascii-font-family:Tahoma;
	mso-fareast-font-family:"Times New Roman";
	mso-fareast-theme-font:minor-fareast;
	mso-hansi-font-family:Tahoma;
	mso-bidi-font-family:Tahoma;}
span.SpellE
	{mso-style-name:"";
	mso-spl-e:yes;}
span.GramE
	{mso-style-name:"";
	mso-gram-e:yes;}
.MsoChpDefault
	{mso-style-type:export-only;
	mso-default-props:yes;
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-fareast-font-family:Calibri;
	mso-fareast-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;
	mso-bidi-font-family:"Times New Roman";
	mso-bidi-theme-font:minor-bidi;}
.MsoPapDefault
	{mso-style-type:export-only;
	margin-bottom:10.0pt;
	line-height:115%;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;
	mso-header-margin:.5in;
	mso-footer-margin:.5in;
	mso-paper-source:0;}
div.WordSection1
	{page:WordSection1;}
-->
</style><!--[if gte mso 10]>
<style>
 /* Style Definitions */
 table.MsoNormalTable
	{mso-style-name:"Table Normal";
	mso-tstyle-rowband-size:0;
	mso-tstyle-colband-size:0;
	mso-style-noshow:yes;
	mso-style-priority:99;
	mso-style-qformat:yes;
	mso-style-parent:"";
	mso-padding-alt:0in 5.4pt 0in 5.4pt;
	mso-para-margin-top:0in;
	mso-para-margin-right:0in;
	mso-para-margin-bottom:10.0pt;
	mso-para-margin-left:0in;
	line-height:115%;
	mso-pagination:widow-orphan;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";
	mso-ascii-font-family:Calibri;
	mso-ascii-theme-font:minor-latin;
	mso-hansi-font-family:Calibri;
	mso-hansi-theme-font:minor-latin;}
</style>
<![endif]--><!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"2050"/>
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1"/>
 </o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
            class=3D"SpellE"><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:black">Catalin</span></span><span
            style=3D"font-size:10.0pt;font-family:
            &quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black">
            Vasile<o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:black">Intern,
            DN-Software<o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
            class=3D"SpellE"><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:black">Freescale</span></span><span
            style=3D"font-size:10.0pt;font-family:
            &quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black">
            Semiconductor, Inc.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:blue;mso-ansi-language:ES-TRAD"
            lang=3D"ES-TRAD"><a class=3D"moz-txt-link-abbreviated" href=3D=
"http://www.freescale.com">www.freescale.com</a><o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
            class=3D"SpellE"><span class=3D"GramE"><span
                style=3D"font-size:10.0pt;
font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black;mso-ans=
i-language:ES-TRAD"
                lang=3D"ES-TRAD">phone</span></span></span><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:black;mso-ansi-language:ES-TRAD"
            lang=3D"ES-TRAD">: 073-021-1938<o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
            class=3D"GramE"><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:black">e-mail</span></span><span
            style=3D"font-size:10.0pt;font-family:
            &quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black">: <a
              href=3D"mailto:your.name@freescale.com">catalin.vasile@free=
scale.com</a></span><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;
            color:black;mso-ansi-language:ES-TRAD" lang=3D"ES-TRAD"><o:p>=
</o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><b
            style=3D"mso-bidi-font-weight:normal"><span
              style=3D"font-size:10.0pt;font-family:
&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:black;mso-no-proof:yes"><=
!--[if gte vml 1]><v:shapetype
 id=3D"_x0000_t75" coordsize=3D"21600,21600" o:spt=3D"75" o:preferrelativ=
e=3D"t"
 path=3D"m@4@5l@4@11@9@11@9@5xe" filled=3D"f" stroked=3D"f">
 <v:stroke joinstyle=3D"miter"/>
 <v:formulas>
  <v:f eqn=3D"if lineDrawn pixelLineWidth 0"/>
  <v:f eqn=3D"sum @0 1 0"/>
  <v:f eqn=3D"sum 0 0 @1"/>
  <v:f eqn=3D"prod @2 1 2"/>
  <v:f eqn=3D"prod @3 21600 pixelWidth"/>
  <v:f eqn=3D"prod @3 21600 pixelHeight"/>
  <v:f eqn=3D"sum @0 0 1"/>
  <v:f eqn=3D"prod @6 1 2"/>
  <v:f eqn=3D"prod @7 21600 pixelWidth"/>
  <v:f eqn=3D"sum @8 21600 0"/>
  <v:f eqn=3D"prod @7 21600 pixelHeight"/>
  <v:f eqn=3D"sum @10 21600 0"/>
 </v:formulas>
 <v:path o:extrusionok=3D"f" gradientshapeok=3D"t" o:connecttype=3D"rect"=
/>
 <o:lock v:ext=3D"edit" aspectratio=3D"t"/>
</v:shapetype><v:shape id=3D"Picture_x0020_1" o:spid=3D"_x0000_i1025" typ=
e=3D"#_x0000_t75"
 alt=3D"Freescale_Logo-nosemi_Lh_4c" style=3D'width:146.25pt;height:54.75=
pt;
 visibility:visible;mso-wrap-style:square'>
 <v:imagedata src=3D"file:///home/b50542/Desktop/WinHome/Documents/email_=
signature_files/image001.png" o:title=3D"Freescale_Logo-nosemi_Lh_4c"/>
</v:shape><![endif]--><!--[if !vml]--><img
                src=3D"cid:part2.02050200.02080404@freescale.com"
                alt=3D"Freescale_Logo-nosemi_Lh_4c"
                v:shapes=3D"Picture_x0020_1" border=3D"0" height=3D"73"
                width=3D"195"><!--[endif]--></span></b><b
            style=3D"mso-bidi-font-weight:
            normal"><span
style=3D"font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif=
&quot;;color:black"><o:p></o:p></span></b></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
style=3D"font-size:7.5pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;;color:black">This
e-mail,
            and any associated attachments have been classified as:<o:p><=
/o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
style=3D"font-size:7.5pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;;color:black">[
            ]
            Public<o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
style=3D"font-size:7.5pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;;color:black">[
            ] <span class=3D"SpellE">Freescale</span> Semiconductor
            Internal Use Only<o:p></o:p></span></p>
        <p class=3D"MsoNormal"
          style=3D"mso-layout-grid-align:none;text-autospace:none"><span
style=3D"font-size:7.5pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&=
quot;;color:black">[
            ] <span class=3D"SpellE">Freescale</span> Semiconductor
            Confidential Proprietary<o:p></o:p></span></p>
      </div>
    </div>
  </body>
</html>

--------------070708010300010403020809
Content-Type: image/gif; name="image002.gif"
Content-Transfer-Encoding: base64
Content-ID: <part2.02050200.02080404@freescale.com>
Content-Disposition: inline; filename="image002.gif"

R0lGODlhwwBJAHcAMSH+GlNvZnR3YXJlOiBNaWNyb3NvZnQgT2ZmaWNlACH5BAEAAAAALBkA
EACeACgAhwAAAAAAAAAAMwAAZgAAmQAAzAAA/wAzAAAzMwAzZgAzmQAzzAAz/wBmAABmMwBm
ZgBmmQBmzABm/wCZAACZMwCZZgCZmQCZzACZ/wDMAADMMwDMZgDMmQDMzADM/wD/AAD/MwD/
ZgD/mQD/zAD//zMAADMAMzMAZjMAmTMAzDMA/zMzADMzMzMzZjMzmTMzzDMz/zNmADNmMzNm
ZjNmmTNmzDNm/zOZADOZMzOZZjOZmTOZzDOZ/zPMADPMMzPMZjPMmTPMzDPM/zP/ADP/MzP/
ZjP/mTP/zDP//2YAAGYAM2YAZmYAmWYAzGYA/2YzAGYzM2YzZmYzmWYzzGYz/2ZmAGZmM2Zm
ZmZmmWZmzGZm/2aZAGaZM2aZZmaZmWaZzGaZ/2bMAGbMM2bMZmbMmWbMzGbM/2b/AGb/M2b/
Zmb/mWb/zGb//5kAAJkAM5kAZpkAmZkAzJkA/5kzAJkzM5kzZpkzmZkzzJkz/5lmAJlmM5lm
ZplmmZlmzJlm/5mZAJmZM5mZZpmZmZmZzJmZ/5nMAJnMM5nMZpnMmZnMzJnM/5n/AJn/M5n/
Zpn/mZn/zJn//8wAAMwAM8wAZswAmcwAzMwA/8wzAMwzM8wzZswzmcwzzMwz/8xmAMxmM8xm
ZsxmmcxmzMxm/8yZAMyZM8yZZsyZmcyZzMyZ/8zMAMzMM8zMZszMmczMzMzM/8z/AMz/M8z/
Zsz/mcz/zMz///8AAP8AM/8AZv8Amf8AzP8A//8zAP8zM/8zZv8zmf8zzP8z//9mAP9mM/9m
Zv9mmf9mzP9m//+ZAP+ZM/+ZZv+Zmf+ZzP+Z///MAP/MM//MZv/Mmf/MzP/M////AP//M///
Zv//mf//zP///wECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwECAwEC
AwECAwECAwECAwECAwECAwECAwj/AAEIHEiwIEFoBhMqXMiwocOHECNKnDgxGjRhyTxdi0ax
o8ePIEOKHHhRmLBgJpNxHMmypcuXDFsBSIbskrBOwmwiQwizp8+fHZWZNIkyGLKdAp1Zuwa0
qVOn0UzinAqNJ4Bn1I5RU/q0q9eR2KAlOyls50przpo1c3ZsLQCmX+PKnQitlEBsz9I2O5aW
rTNo2OYKHuzwmjO9atVyFTjWKuHHg6EdZrt360BTyYwGS5bMMeTPXtFScysw2liURIN5Bs36
KTWeY2/mvMm5te24pokO3Xy7t1dsymLbFBZtpe/jMK1Bg2uxrErk0FuG7essuvWezxIntna9
e0i0eylr/60OAFtg7+gdQhutXe0z7mE7K4t4Pv1xa3zzp10qsORmuwtdEcAVLLBwhX0dBRCA
T9HAJVBeaz0zkFC6oWbcQK0IqKCCgiAoEQsbLvhSKWMVR9J7pdE01WyeQHOhQBpuyIKHEgki
o3RikYVRZwWVVCFnqwHQCogKFjgjjQ8JEuOBLJWEk02XPFdQbDjxVl9BBG5okJJ3yYTlka14
qRCBd115V4cAkLmQIEdegWZBXqpp3kAFbvimQEPC+CaTYhLEGWq7JTMfAKuNhQwALw4UY5Ec
AmAkC0oa+OajARTo5pZZgmhgn0JeIaCmkhYUKaiXDoSNp3VqWqpAIYo5aqVGBv+W4aoTJmPT
isJYVU0zW3E3YUNEhqjgFUPKuKGXdQo74JsZKnsshsEKuymM0crI5KnVhqiotgIp6WyBQip5
p59DIZMMXOAldliQCWULq43KHumultsyKiyTWdobYpv7Jlspk8G6uSiT8FbabbwyjqsQNJ4k
IxBTh+nH12JJEgkutTLWmWbCAiV7xXk3DsRtjGASCCmdG5aqaoefDohyo46m3HHKyMo8UXbt
8fqMgxBZPGnGccroqs3BCnJes40GzORd9Ro8kLjncRmmyPTG3OiSBAV7ZESGhcdXMxImWCRB
+xJUsIGeshmy0mmH2KG0kLoZNccVV0u1guXtK66n3Db/FM152FiTrlLsNrQotCHP7GyIH88r
bJiL6t3KqYknFFi+yhKs9+LSPjSWwwRZE7ZHWB9c5NIFc14pNo6P3LKygng77ELYqM0o5vim
/LbqszPEGVnmthTwy06bXnxCtovoUOyalj38QgHXDPPwASv8UFm3zpaMmR4FK+bzxgfQZ6iK
G0hQKwHcKUifyR8IPgCxd1i7zayOrXj6VuOPIYGc9jiUbJtRRqI8IrSmKQ9+jCtPh4h0IKS5
LFw+K9aMjHa/BbotdhsbEOsKmD/zAcBYGcTb5EJovVbYSjZUKQ9LUkeQ0hFvWdGSX7TQti/0
Mc5NWgtM6gbkrwORzE33QpPPeoQkrEhVriDK8A9GBOgSF+brZGbjHBTvl7nJRU5aaCrW4tC0
w8zByGYOjNfSFvY57onEYkurYUFq17wibQ1xlUrZGIektX+x73WwEhMdM1a6BHYLjyCy3nVa
oaS0MaSQnuqfkAjpKWIpEn6FLGEkOxK7Rj4SSZikSEAAADs=
--------------070708010300010403020809--

--------------010203000503020200040500--

--===============5804435976077383832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5804435976077383832==--
